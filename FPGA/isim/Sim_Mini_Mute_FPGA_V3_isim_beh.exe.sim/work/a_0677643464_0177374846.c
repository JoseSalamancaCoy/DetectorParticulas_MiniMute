/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Jose Luis/Jose UIS/Proyecto de grado/Interfaz_digita/FPGA_V2/Mini_Mute_FPGA_V3/paralelo_serial.vhd";



static void work_a_0677643464_0177374846_p_0(char *t0)
{
    unsigned char t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    int t17;
    int t18;
    int t19;
    int t20;
    int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    int t25;
    int t26;
    int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t31;
    char *t32;

LAB0:    xsi_set_current_line(44, ng0);
    t2 = (t0 + 1472U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 3840);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(45, ng0);
    t4 = (t0 + 1672U);
    t8 = *((char **)t4);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB8;

LAB10:    t2 = (t0 + 1192U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = (t1 == (unsigned char)3);
    if (t3 != 0)
        goto LAB11;

LAB12:    t2 = (t0 + 1352U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = (t1 == (unsigned char)3);
    if (t3 != 0)
        goto LAB13;

LAB14:
LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1512U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(46, ng0);
    t4 = xsi_get_transient_memory(40U);
    memset(t4, 0, 40U);
    t11 = t4;
    memset(t11, (unsigned char)2, 40U);
    t12 = (t0 + 3936);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t4, 40U);
    xsi_driver_first_trans_fast(t12);
    goto LAB9;

LAB11:    xsi_set_current_line(48, ng0);
    t2 = (t0 + 1032U);
    t5 = *((char **)t2);
    t2 = (t0 + 3936);
    t8 = (t2 + 56U);
    t11 = *((char **)t8);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t5, 40U);
    xsi_driver_first_trans_fast(t2);
    goto LAB9;

LAB13:    xsi_set_current_line(50, ng0);
    t17 = (40 - 2);
    t2 = (t0 + 6692);
    *((int *)t2) = 0;
    t5 = (t0 + 6696);
    *((int *)t5) = t17;
    t18 = 0;
    t19 = t17;

LAB15:    if (t18 <= t19)
        goto LAB16;

LAB18:    xsi_set_current_line(53, ng0);
    t2 = (t0 + 3936);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_delta(t2, 39U, 1, 0LL);
    goto LAB9;

LAB16:    xsi_set_current_line(51, ng0);
    t8 = (t0 + 1992U);
    t11 = *((char **)t8);
    t8 = (t0 + 6692);
    t20 = *((int *)t8);
    t21 = (t20 - 39);
    t22 = (t21 * -1);
    xsi_vhdl_check_range_of_index(39, 0, -1, *((int *)t8));
    t23 = (1U * t22);
    t24 = (0 + t23);
    t12 = (t11 + t24);
    t6 = *((unsigned char *)t12);
    t13 = (t0 + 6692);
    t25 = *((int *)t13);
    t26 = (t25 + 1);
    t27 = (t26 - 39);
    t28 = (t27 * -1);
    t29 = (1 * t28);
    t30 = (0U + t29);
    t14 = (t0 + 3936);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t31 = (t16 + 56U);
    t32 = *((char **)t31);
    *((unsigned char *)t32) = t6;
    xsi_driver_first_trans_delta(t14, t30, 1, 0LL);

LAB17:    t2 = (t0 + 6692);
    t18 = *((int *)t2);
    t4 = (t0 + 6696);
    t19 = *((int *)t4);
    if (t18 == t19)
        goto LAB18;

LAB19:    t17 = (t18 + 1);
    t18 = t17;
    t5 = (t0 + 6692);
    *((int *)t5) = t18;
    goto LAB15;

}

static void work_a_0677643464_0177374846_p_1(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    int t4;
    unsigned int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned char t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;

LAB0:    xsi_set_current_line(57, ng0);

LAB3:    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t3 = (40 - 1);
    t4 = (t3 - 39);
    t5 = (t4 * -1);
    t6 = (1U * t5);
    t7 = (0 + t6);
    t1 = (t2 + t7);
    t8 = *((unsigned char *)t1);
    t9 = (t0 + 4000);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    *((unsigned char *)t13) = t8;
    xsi_driver_first_trans_fast_port(t9);

LAB2:    t14 = (t0 + 3856);
    *((int *)t14) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_0677643464_0177374846_init()
{
	static char *pe[] = {(void *)work_a_0677643464_0177374846_p_0,(void *)work_a_0677643464_0177374846_p_1};
	xsi_register_didat("work_a_0677643464_0177374846", "isim/Sim_Mini_Mute_FPGA_V3_isim_beh.exe.sim/work/a_0677643464_0177374846.didat");
	xsi_register_executes(pe);
}
