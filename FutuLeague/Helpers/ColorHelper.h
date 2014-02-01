//
//  ColorHelper.h
//  FutuLeague
//
//  Created by Martin Richter on 01/02/14.
//  Copyright (c) 2014 Futurice. All rights reserved.
//

#define COLOR_RGBA(r,g,b,a) [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:(a)]
#define COLOR_RGB(r,g,b)    COLOR_RGBA(r,g,b,1.0)
#define COLOR_HSBA(h,s,b,a) [UIColor colorWithHue:(h) saturation:(s) brightness:(b) alpha:(a)]
#define COLOR_HSB(h,s,b)    COLOR_HSBA(h,s,b,1.0)

#define COLOR_HEX(__hex)      COLOR_RGB(((__hex >> 16) & 0xFF)/255.0f, ((__hex >> 8) & 0xFF)/255.0f, (__hex & 0xFF)/255.0f)
#define COLOR_HEX_A(__hex,a)  COLOR_RGBA(((__hex >> 16) & 0xFF)/255.0f, ((__hex >> 8) & 0xFF)/255.0f, (__hex & 0xFF)/255.0f, (a))
