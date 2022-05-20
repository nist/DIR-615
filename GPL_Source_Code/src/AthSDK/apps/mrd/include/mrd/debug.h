#ifndef _mrd_debug_h_
#define _mrd_debug_h_

#define assert_debug(cond, msg, what) \
	if (!cond) { \
		g_mrd->log().info(NORMAL) << "ASSERT failed at " << __FILE__ << ":" << __LINE__ << " with " << msg << endl; \
		what; \
	}

#endif

