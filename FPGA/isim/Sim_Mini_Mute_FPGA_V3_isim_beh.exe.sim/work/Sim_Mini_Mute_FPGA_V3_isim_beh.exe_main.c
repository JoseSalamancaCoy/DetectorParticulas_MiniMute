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

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_2592010699;
char *STD_STANDARD;
char *IEEE_P_1242562249;
char *IEEE_P_3620187407;
char *IEEE_P_3499444699;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    work_a_3734969786_3212880686_init();
    work_a_1696877448_3212880686_init();
    work_a_1536893274_3212880686_init();
    work_a_2261254411_3212880686_init();
    ieee_p_1242562249_init();
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    work_a_0435796524_3212880686_init();
    work_a_0457711641_3212880686_init();
    work_a_1022211543_3212880686_init();
    work_a_1005758503_0177374846_init();
    work_a_3157540411_3212880686_init();
    work_a_0542382389_3212880686_init();
    work_a_2558459877_0177374846_init();
    work_a_3248055293_1022624960_init();
    work_a_4070205984_3212880686_init();
    work_a_0759944787_0177374846_init();
    work_a_3261455395_0177374846_init();
    work_a_3405992329_3212880686_init();
    work_a_2670959898_3212880686_init();
    work_a_4109704175_3212880686_init();
    work_a_0677643464_0177374846_init();
    work_a_2491033182_3212880686_init();
    work_a_0003746491_0177374846_init();
    work_a_0576801742_3212880686_init();
    work_a_2368183470_3212880686_init();
    work_a_1908027624_3212880686_init();
    work_a_1630590541_3212880686_init();
    work_a_0418979446_3212880686_init();
    work_a_2397351853_3212880686_init();
    work_a_3964026897_2372691052_init();


    xsi_register_tops("work_a_3964026897_2372691052");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");

    return xsi_run_simulation(argc, argv);

}
