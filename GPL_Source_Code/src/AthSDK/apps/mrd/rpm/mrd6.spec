Summary: Multicast Routing Daemon for IPv6
Name: mrd6
Version: 0.9.4_beta2
Release: 1
URL: http://artemis.av.it.pt/mrd6/
License: GPL
Source0: http://artemis.av.it.pt/mrd6/mrd6-0.9.4-beta2.tar.gz
Group: Networking
Packager: Hugo Santos <hsantos@av.it.pt>
BuildRoot: %{_builddir}/%{name}-%{version}-root

%description
  MRD6 is a modular IPv6 Multicast Routing Daemon which implements:
    * MLDv1 and MLDv2 with forwarding capabilities
      - MLD proxying
    * PIM-SM (ASM and SSM)
      - Bootstrap (BSR) Mechanism support
      - Static RP configuration
      - Embedded-RP support
    * partial MBGP support
      - Uses IPv6 Multicast SAFI prefixes announced by
        peers to update local MRIB
      - Is able to announce local prefixes
      - Filter support
    * Native and virtual (tunnel) interfaces support
    * CLI support (remote configuration and management) via
      telnet or local access
    * SNMP support as a SMUX agent

%prep
%setup -q -n mrd6-0.9.4-beta2

%build
make -C src
make -C src bgp
make -C tools/c

%install
[ %{buildroot} != "/" ] && rm -rf %{buildroot}
PREFIX=%{_prefix} DESTDIR=%{buildroot} make -C src install
PREFIX=%{_prefix} DESTDIR=%{buildroot} make -C src install_bgp
PREFIX=%{_prefix} DESTDIR=%{buildroot} make -C tools/c install

%clean
[ %{buildroot} != "/" ] && rm -rf %{buildroot}

%files
%defattr(-, root, root)
%doc README MRD6shQuickRef.txt src/confs/mrd.conf
%{_prefix}/sbin/mrd6
%{_prefix}/lib/mrd6/*
%{_prefix}/bin/mrd6sh

%changelog
* Mon Oct 17 2005 Hugo Santos <hsantos@av.it.pt> 0.9.4_beta2
- 0.9.4-beta2
