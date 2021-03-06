# OpenVPN spec file, used to drive rpmbuild

# OPTIONS
#
# Disable LZO
#   rpmbuild -tb [openvpn.x.tar.gz] --define 'without_lzo 1'
#
# Disable PAM plugin
#   rpmbuild -tb [openvpn.x.tar.gz] --define 'without_pam 1'
#
# Allow passwords to be read from files
#   rpmbuild -tb [openvpn.x.tar.gz] --define 'with_password_save 1'
#
# Use this on RH9 and RHEL3
#   rpmbuild -tb [openvpn.x.tar.gz] --define 'with_kerberos 1'

Summary:	OpenVPN is a robust and highly flexible VPN daemon by James Yonan.
Name:           openvpn
Version:        2.1_rc9
Release:	1
URL:		http://openvpn.net/
Source0:	http://prdownloads.sourceforge.net/openvpn/%{name}-%{version}.tar.gz

License:	GPL
Group:		Applications/Internet
Vendor:		James Yonan <jim@yonan.net>
Packager:	James Yonan <jim@yonan.net>
BuildRoot:	%{_tmppath}/%{name}-%(id -un)

#
# Include dependencies manually
#

AutoReq: 0

BuildRequires: openssl-devel >= 0.9.6
Requires:      openssl       >= 0.9.6

%if "%{_vendor}" == "Mandrakesoft"
%{!?without_lzo:BuildRequires: liblzo1-devel >= 1.07}
%{!?without_lzo:Requires:      liblzo1       >= 1.07}
%else
%if "%{_vendor}" == "MandrakeSoft"
%{!?without_lzo:BuildRequires: liblzo1-devel >= 1.07}
%{!?without_lzo:Requires:      liblzo1       >= 1.07}
%else
%{!?without_lzo:BuildRequires: lzo-devel >= 1.07}
%{!?without_lzo:Requires:      lzo       >= 1.07}
%endif
%endif

%{!?without_pam:BuildRequires: pam-devel}
%{!?without_pam:Requires:      pam}

%{!?with_pkcs11:BuildRequires: pkcs11-helper-devel}
%{!?with_pkcs11:Requires:      pkcs11-helper}

#
# Description
#

%description
OpenVPN is a robust and highly flexible VPN daemon by James Yonan.
OpenVPN supports SSL/TLS security,
ethernet bridging,
TCP or UDP tunnel transport through proxies or NAT,
support for dynamic IP addresses and DHCP,
scalability to hundreds or thousands of users,
and portability to most major OS platforms.

#
# Define vendor type
#

%if "%{_vendor}" == "suse" || "%{_vendor}" == "pc"
%define VENDOR SuSE
%else
%define VENDOR %_vendor
%endif

#
# Should we build the auth-pam module?
#

%define build_auth_pam 1
%{?without_pam:%define build_auth_pam 0}

#
# Other definitions
#

%define debug_package %{nil}

#
# Build OpenVPN binary
#

%prep
%setup -q

%build
%configure --disable-dependency-tracking %{?with_password_save:--enable-password-save} %{?without_lzo:--disable-lzo} %{?with_kerberos:--with-ssl-headers=/usr/kerberos/include}
%__make
%__strip %{name}

# Build down-root plugin
pushd plugin/down-root
%__make
popd

# Build auth-pam plugin
%if %{build_auth_pam}
pushd plugin/auth-pam
%__make
popd
%endif

#
# Installation section
#

%install
[ %{buildroot} != "/" ] && rm -rf %{buildroot}

# Install man page
%__install -c -d -m 755 %{buildroot}%{_mandir}/man8
%__install -c -m 755 %{name}.8 %{buildroot}%{_mandir}/man8

# Install binary
%__install -c -d -m 755 %{buildroot}%{_sbindir}
%__install -c -m 755 %{name} %{buildroot}%{_sbindir}

# Install init script
%if "%{VENDOR}" == "SuSE"
%__install -c -d -m 755 %{buildroot}/etc/init.d
%__sed -e 's#openvpn=\"/usr/local/sbin/openvpn\"#openvpn=\"/usr/sbin/openvpn\"#' < suse/%{name}.init > %{_tmppath}/%{name}.init
%__install -c -m 755 %{_tmppath}/%{name}.init %{buildroot}/etc/init.d/%{name}
%__rm %{_tmppath}/%{name}.init 
%else
%__install -c -d -m 755 %{buildroot}/etc/rc.d/init.d
%__install -c -m 755 sample-scripts/%{name}.init %{buildroot}/etc/rc.d/init.d/%{name}
%endif

# Install /etc/openvpn
%__install -c -d -m 755 %{buildroot}/etc/%{name}

#
# Build /usr/share/openvpn
#

%__mkdir_p %{buildroot}%{_datadir}/%{name}

#
# Install the plugins
#

%__mkdir_p %{buildroot}%{_datadir}/%{name}/plugin/lib

for pi in auth-pam down-root; do
  %__mv -f plugin/$pi/README plugin/README.$pi
  if [ -e plugin/$pi/openvpn-$pi.so ]; then
    %__install -c -m 755 plugin/$pi/openvpn-$pi.so %{buildroot}%{_datadir}/openvpn/plugin/lib/openvpn-$pi.so
  fi
done

%__mv -f plugin/README plugin/README.plugins

#
# Clean section
#

%clean
[ %{buildroot} != "/" ] && rm -rf %{buildroot}

#
# On Linux 2.4, make the device node
#

%post
case "`uname -r`" in
2.4*)
	/bin/mkdir /dev/net >/dev/null 2>&1
	/bin/mknod /dev/net/tun c 10 200 >/dev/null 2>&1
	;;
esac

#
# Handle the init script
#

/sbin/chkconfig --add %{name}
%if "%{VENDOR}" == "SuSE"
/etc/init.d/openvpn restart
%else
/sbin/service %{name} condrestart
%endif
%preun
if [ "$1" = 0 ]
then
	%if "%{VENDOR}" == "SuSE"
	/etc/init.d/openvpn stop
	%else
	/sbin/service %{name} stop
	%endif
	/sbin/chkconfig --del %{name}
fi

#
# Files section
#

%files
%defattr(-,root,root)
%doc AUTHORS ChangeLog COPYING COPYRIGHT.GPL INSTALL NEWS PORTS README 
%{_mandir}/man8/%{name}.8*
%{_sbindir}/%{name}
%{_datadir}/%{name}
%dir /etc/%{name}
%if "%{VENDOR}" == "SuSE"
/etc/init.d/%{name}
%else
/etc/rc.d/init.d/%{name}
%endif

# Install extra %doc stuff
%doc contrib/ easy-rsa/ management/ sample-*/ plugin/README.*

%changelog
* Thu Dec 14 2006 Alon Bar-Lev
- Added with_pkcs11

* Mon Aug 2 2005 James Yonan
- Fixed build problem with --define 'without_pam 1'

* Mon Apr 4 2005 James Yonan
- Moved some files from /usr/share/openvpn to %doc for compatibility
  with Dag Wieers' RPM repository

* Sat Mar 12 2005 Tom Walsh
- Added MandrakeSoft liblzo1 require

* Fri Dec 10 2004 James Yonan
- Added AutoReq: 0 for manual dependencies

* Fri Dec 10 2004 James Yonan
- Packaged the plugins

* Sun Nov 7 2004 Umberto Nicoletti
- SuSE support

* Wed Aug 18 2004 Bishop Clark (LC957) <bishop@platypus.bc.ca>
- restrict what we claim in /etc/ to avoid ownership conflicts

* Sun Feb 23 2003 Matthias Andree <matthias.andree@gmx.de> 1.3.2.14-1.
- Have the version number filled in by autoconf.

* Wed Jul 10 2002 James Yonan <jim@yonan.net> 1.3.1-1
- Fixed %preun to only remove service on final uninstall

* Mon Jun 17 2002 bishop clark (LC957) <bishop@platypus.bc.ca> 1.2.2-1
- Added condrestart to openvpn.spec & openvpn.init.

* Wed May 22 2002 James Yonan <jim@yonan.net> 1.2.0-1
- Added mknod for Linux 2.4.

* Wed May 15 2002 Doug Keller <dsk@voidstar.dyndns.org> 1.1.1.16-2
- Added init scripts
- Added conf file support

* Mon May 13 2002 bishop clark (LC957) <bishop@platypus.bc.ca> 1.1.1.14-1
- Added new directories for config examples and such

* Sun May 12 2002 bishop clark (LC957) <bishop@platypus.bc.ca> 1.1.1.13-1
- Updated buildroot directive and cleanup command
- added easy-rsa utilities

* Mon Mar 25 2002 bishop clark (LC957) <bishop@platypus.bc.ca> 1.0-1
- Initial build.
