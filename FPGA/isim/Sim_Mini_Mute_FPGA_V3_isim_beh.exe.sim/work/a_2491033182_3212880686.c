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
static const char *ng0 = "C:/Jose Luis/Jose UIS/Proyecto de grado/Interfaz_digita/FPGA_V2/Mini_Mute_FPGA_V3/Serial_Paralelo.vhd";



static void work_a_2491033182_3212880686_p_0(char *t0)
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
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    int t24;
    int t25;
    int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    char *t30;
    char *t31;

LAB0:    xsi_set_current_line(41, ng0);
    t2 = (t0 + 1312U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 3560);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(42, ng0);
    t4 = (t0 + 1512U);
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

LAB12:
LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1352U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(43, ng0);
    t4 = xsi_get_transient_memory(9U);
    memset(t4, 0, 9U);
    t11 = t4;
    memset(t11, (unsigned char)2, 9U);
    t12 = (t0 + 3656);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t4, 9U);
    xsi_driver_first_trans_fast(t12);
    goto LAB9;

LAB11:    xsi_set_current_line(45, ng0);
    t2 = (t0 + 6121);
    *((int *)t2) = 0;
    t5 = (t0 + 6125);
    *((int *)t5) = 7;
    t17 = 0;
    t18 = 7;

LAB13:    if (t17 <= t18)
        goto LAB14;

LAB16:    xsi_set_current_line(48, ng0);
    t2 = (t0 + 1032U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t2 = (t0 + 3656);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = t1;
    xsi_driver_first_trans_delta(t2, 8U, 1, 0LL);
    goto LAB9;

LAB14:    xsi_set_current_line(46, ng0);
    t8 = (t0 + 1832U);
    t11 = *((char **)t8);
    t8 = (t0 + 6121);
    t19 = *((int *)t8);
    t20 = (t19 - 8);
    t21 = (t20 * -1);
    xsi_vhdl_check_range_of_index(8, 0, -1, *((int *)t8));
    t22 = (1U * t21);
    t23 = (0 + t22);
    t12 = (t11 + t23);
    t6 = *((unsigned char *)t12);
    t13 = (t0 + 6121);
    t24 = *((int *)t13);
    t25 = (t24 + 1);
    t26 = (t25 - 8);
    t27 = (t26 * -1);
    t28 = (1 * t27);
    t29 = (0U + t28);
    t14 = (t0 + 3656);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t30 = (t16 + 56U);
    t31 = *((char **)t30);
    *((unsigned char *)t31) = t6;
    xsi_driver_first_trans_delta(t14, t29, 1, 0LL);

LAB15:    t2 = (t0 + 6121);
    t17 = *((int *)t2);
    t4 = (t0 + 6125);
    t18 = *((int *)t4);
    if (t17 == t18)
        goto LAB16;

LAB17:    t19 = (t17 + 1);
    t17 = t19;
    t5 = (t0 + 6121);
    *((int *)t5) = t17;
    goto LAB13;

}

static void work_a_2491033182_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(53, ng0);

LAB3:    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t1 = (t0 + 3720);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 9U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 3576);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_2491033182_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2491033182_3212880686_p_0,(void *)work_a_2491033182_3212880686_p_1};
	xsi_register_didat("work_a_2491033182_3212880686", "isim/Sim_Mini_Mute_FPGA_V3_isim_beh.exe.sim/work/a_2491033182_3212880686.didat");
	xsi_register_executes(pe);
}
