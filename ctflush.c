#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <libnetfilter_conntrack/libnetfilter_conntrack.h>
#include <errno.h>
#include <string.h>
#include <time.h>

int main(void){
	int res  = 0;
	int family = AF_UNSPEC;
	struct nfct_handle *cth;
	cth = nfct_open(CONNTRACK, 0);
	if (!cth)
		perror("Can't open handler");
	res = nfct_query(cth, NFCT_Q_FLUSH, &family);
	nfct_close(cth);
	printf("ctflush: connection tracking table has been emptied.\n");
	return 0;
}
