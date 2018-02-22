#ifndef _LSUSB_H
#define _LSUSB_H

extern int lsusb_t(void);

#if defined(__APPLE__) || defined(__darwin__)
extern void iousb_t(void);
#endif

#endif
