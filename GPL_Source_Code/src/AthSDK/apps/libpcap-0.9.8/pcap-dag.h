/*
 * pcap-dag.c: Packet capture interface for Endace DAG card.
 *
 * The functionality of this code attempts to mimic that of pcap-linux as much
 * as possible.  This code is only needed when compiling in the DAG card code
 * at the same time as another type of device.
 *
 * Author: Richard Littin, Sean Irvine ({richard,sean}@reeltwo.com)
 *
 * @(#) $Header: /cvsroot/Eagle/apps/libpcap-0.9.8/pcap-dag.h,v 1.1 2008/09/30 10:15:33 ken_chiang Exp $ (LBL)
 */

pcap_t *dag_open_live(const char *device, int snaplen, int promisc, int to_ms, char *ebuf);
int dag_platform_finddevs(pcap_if_t **devlistp, char *errbuf);
