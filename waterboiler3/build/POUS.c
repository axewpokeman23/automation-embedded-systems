void LOGGER_init__(LOGGER *data__, BOOL retain) {
  __INIT_VAR(data__->EN,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->ENO,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->TRIG,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->MSG,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->LEVEL,LOGLEVEL__INFO,retain)
  __INIT_VAR(data__->TRIG0,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void LOGGER_body__(LOGGER *data__) {
  // Control execution
  if (!__GET_VAR(data__->EN)) {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(FALSE));
    return;
  }
  else {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(TRUE));
  }
  // Initialise TEMP variables

  if ((__GET_VAR(data__->TRIG,) && !(__GET_VAR(data__->TRIG0,)))) {
    #define GetFbVar(var,...) __GET_VAR(data__->var,__VA_ARGS__)
    #define SetFbVar(var,val,...) __SET_VAR(data__->,var,__VA_ARGS__,val)

   LogMessage(GetFbVar(LEVEL),(char*)GetFbVar(MSG, .body),GetFbVar(MSG, .len));
  
    #undef GetFbVar
    #undef SetFbVar
;
  };
  __SET_VAR(data__->,TRIG0,,__GET_VAR(data__->TRIG,));

  goto __end;

__end:
  return;
} // LOGGER_body__() 





void WATERBOILER_init__(WATERBOILER *data__, BOOL retain) {
  __INIT_VAR(data__->STOPPED_STATE,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->RUN_STATE,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->E_STATE,__BOOL_LITERAL(FALSE),retain)
  __INIT_LOCATED(BOOL,__IX0_0,data__->START_BTN,retain)
  __INIT_LOCATED_VALUE(data__->START_BTN,__BOOL_LITERAL(FALSE))
  __INIT_LOCATED(BOOL,__IX0_1,data__->STOP_BTN,retain)
  __INIT_LOCATED_VALUE(data__->STOP_BTN,__BOOL_LITERAL(FALSE))
  __INIT_LOCATED(BOOL,__IX0_2,data__->E_STOP,retain)
  __INIT_LOCATED_VALUE(data__->E_STOP,__BOOL_LITERAL(FALSE))
  __INIT_LOCATED(BOOL,__IX0_3,data__->TEMP_UP,retain)
  __INIT_LOCATED_VALUE(data__->TEMP_UP,__BOOL_LITERAL(FALSE))
  __INIT_LOCATED(BOOL,__IX0_4,data__->TEMP_DWN,retain)
  __INIT_LOCATED_VALUE(data__->TEMP_DWN,__BOOL_LITERAL(FALSE))
  __INIT_LOCATED(BOOL,__IX0_5,data__->P_SWITCH,retain)
  __INIT_LOCATED_VALUE(data__->P_SWITCH,__BOOL_LITERAL(FALSE))
  __INIT_LOCATED(BOOL,__QX0_0,data__->HEATER,retain)
  __INIT_LOCATED_VALUE(data__->HEATER,__BOOL_LITERAL(FALSE))
  __INIT_LOCATED(BOOL,__QX0_1,data__->LED0,retain)
  __INIT_LOCATED_VALUE(data__->LED0,__BOOL_LITERAL(FALSE))
  __INIT_LOCATED(BOOL,__QX0_2,data__->LED1,retain)
  __INIT_LOCATED_VALUE(data__->LED1,__BOOL_LITERAL(FALSE))
  __INIT_LOCATED(BOOL,__QX0_3,data__->LED2,retain)
  __INIT_LOCATED_VALUE(data__->LED2,__BOOL_LITERAL(FALSE))
  __INIT_LOCATED(BOOL,__QX0_4,data__->LED3,retain)
  __INIT_LOCATED_VALUE(data__->LED3,__BOOL_LITERAL(FALSE))
  __INIT_LOCATED(BOOL,__QX0_5,data__->LED4,retain)
  __INIT_LOCATED_VALUE(data__->LED4,__BOOL_LITERAL(FALSE))
  __INIT_LOCATED(BOOL,__QX0_6,data__->LED5,retain)
  __INIT_LOCATED_VALUE(data__->LED5,__BOOL_LITERAL(FALSE))
  __INIT_LOCATED(BOOL,__QX0_7,data__->E_LED,retain)
  __INIT_LOCATED_VALUE(data__->E_LED,__BOOL_LITERAL(FALSE))
  __INIT_LOCATED(INT,__MW0,data__->SETPOINT,retain)
  __INIT_LOCATED_VALUE(data__->SETPOINT,80)
  __INIT_LOCATED(INT,__IW0_0,data__->VOLT,retain)
  __INIT_LOCATED_VALUE(data__->VOLT,0)
  __INIT_LOCATED(INT,__MW1,data__->ACTUAL_TEMPERATURE,retain)
  __INIT_LOCATED_VALUE(data__->ACTUAL_TEMPERATURE,0)
  __INIT_LOCATED(INT,__QW0,data__->SERVO,retain)
  __INIT_LOCATED_VALUE(data__->SERVO,0)
  SR_init__(&data__->SR0,retain);
  R_TRIG_init__(&data__->R_TRIG0,retain);
  R_TRIG_init__(&data__->R_TRIG1,retain);
  __INIT_LOCATED(INT,__MW2,data__->STATUS_RUN,retain)
  __INIT_LOCATED_VALUE(data__->STATUS_RUN,0)
  __INIT_LOCATED(INT,__MW3,data__->STATUS_PWM,retain)
  __INIT_LOCATED_VALUE(data__->STATUS_PWM,0)
  CTUD_init__(&data__->CTUD0,retain);
  PWM_CONTROLLER_init__(&data__->PWM_CONTROLLER0,retain);
  __INIT_LOCATED(INT,__MW4,data__->ANGLE,retain)
  __INIT_LOCATED_VALUE(data__->ANGLE,0)
  __INIT_LOCATED(INT,__MW6,data__->POWER,retain)
  __INIT_LOCATED_VALUE(data__->POWER,0)
  __INIT_LOCATED(INT,__MW7,data__->VOLTMULCURRENT,retain)
  __INIT_LOCATED_VALUE(data__->VOLTMULCURRENT,0)
  __INIT_LOCATED(WORD,__MW8,data__->POWER1,retain)
  __INIT_LOCATED_VALUE(data__->POWER1,0)
  __INIT_LOCATED(INT,__MW9,data__->CURRENT_TEMP,retain)
  __INIT_LOCATED_VALUE(data__->CURRENT_TEMP,0)
  __INIT_LOCATED(INT,__MW5,data__->POWER_PERCENT,retain)
  __INIT_LOCATED_VALUE(data__->POWER_PERCENT,0)
  PID_init__(&data__->PID0,retain);
  __INIT_VAR(data__->CALCPOWER,0,retain)
  R_TRIG_init__(&data__->R_TRIG2,retain);
  R_TRIG_init__(&data__->R_TRIG3,retain);
  __INIT_VAR(data__->_TMP_ADD92_OUT,0,retain)
  __INIT_VAR(data__->_TMP_MUL93_OUT,0,retain)
  __INIT_VAR(data__->_TMP_ADD94_OUT,0,retain)
  __INIT_VAR(data__->_TMP_EQ111_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_EQ22_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_EQ11_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_EQ23_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_EQ31_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_EQ33_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_EQ41_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_EQ42_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_EQ46_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_EQ50_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_EQ51_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_INT_TO_REAL76_OUT,0,retain)
  __INIT_VAR(data__->_TMP_BOOL_TO_INT136_OUT,0,retain)
  __INIT_VAR(data__->_TMP_INT_TO_REAL135_OUT,0,retain)
  __INIT_VAR(data__->_TMP_DIV120_OUT,0,retain)
  __INIT_VAR(data__->_TMP_MUL121_OUT,0,retain)
  __INIT_VAR(data__->_TMP_REAL_TO_INT133_OUT,0,retain)
  __INIT_VAR(data__->_TMP_MUL173_OUT,0,retain)
  __INIT_VAR(data__->_TMP_BOOL_TO_INT163_OUT,0,retain)
  __INIT_VAR(data__->_TMP_INT_TO_REAL182_OUT,0,retain)
  __INIT_VAR(data__->_TMP_REAL_TO_INT180_OUT,0,retain)
  __INIT_VAR(data__->_TMP_MUL73_OUT,0,retain)
  __INIT_VAR(data__->_TMP_DIV70_OUT,0,retain)
  __INIT_VAR(data__->_TMP_DIV191_OUT,0,retain)
  __INIT_VAR(data__->_TMP_MUL192_OUT,0,retain)
  __INIT_VAR(data__->_TMP_REAL_TO_INT81_OUT,0,retain)
  __INIT_VAR(data__->_TMP_REAL_TO_INT71_OUT,0,retain)
  __INIT_VAR(data__->_TMP_REAL_TO_WORD72_OUT,0,retain)
  __INIT_VAR(data__->_TMP_DIV198_OUT,0,retain)
  __INIT_VAR(data__->_TMP_MUL199_OUT,0,retain)
  __INIT_VAR(data__->_TMP_ADD202_OUT,0,retain)
  __INIT_VAR(data__->_TMP_REAL_TO_INT88_OUT,0,retain)
}

// Code part
void WATERBOILER_body__(WATERBOILER *data__) {
  // Initialise TEMP variables

  __SET_VAR(data__->,RUN_STATE,,((__GET_VAR(data__->RUN_STATE,) || __GET_LOCATED(data__->START_BTN,)) && !(__GET_LOCATED(data__->STOP_BTN,))));
  __SET_VAR(data__->,STOPPED_STATE,,(!(__GET_VAR(data__->E_STATE,)) && !(__GET_VAR(data__->RUN_STATE,))));
  __SET_LOCATED(data__->,HEATER,,(!(__GET_VAR(data__->E_STATE,)) && __GET_VAR(data__->RUN_STATE,)));
  __SET_VAR(data__->SR0.,S1,,(__GET_LOCATED(data__->E_STOP,) && __GET_VAR(data__->RUN_STATE,)));
  __SET_VAR(data__->SR0.,R,,((__GET_LOCATED(data__->STOP_BTN,) && __GET_LOCATED(data__->E_STOP,)) && __GET_VAR(data__->E_STATE,)));
  SR_body__(&data__->SR0);
  __SET_VAR(data__->,E_STATE,,__GET_VAR(data__->SR0.Q1,));
  __SET_LOCATED(data__->,E_LED,,__GET_VAR(data__->E_STATE,));
  __SET_VAR(data__->R_TRIG0.,CLK,,((__GET_LOCATED(data__->TEMP_UP,) && !(__GET_VAR(data__->E_STATE,))) && !(__GET_VAR(data__->RUN_STATE,))));
  R_TRIG_body__(&data__->R_TRIG0);
  __SET_VAR(data__->R_TRIG2.,CLK,,__GET_VAR(data__->R_TRIG0.Q,));
  R_TRIG_body__(&data__->R_TRIG2);
  __SET_VAR(data__->R_TRIG1.,CLK,,((__GET_LOCATED(data__->TEMP_DWN,) && !(__GET_VAR(data__->E_STATE,))) && !(__GET_VAR(data__->RUN_STATE,))));
  R_TRIG_body__(&data__->R_TRIG1);
  __SET_VAR(data__->R_TRIG3.,CLK,,__GET_VAR(data__->R_TRIG1.Q,));
  R_TRIG_body__(&data__->R_TRIG3);
  __SET_VAR(data__->CTUD0.,CU,,__GET_VAR(data__->R_TRIG2.Q,));
  __SET_VAR(data__->CTUD0.,CD,,__GET_VAR(data__->R_TRIG3.Q,));
  __SET_VAR(data__->CTUD0.,PV,,10);
  CTUD_body__(&data__->CTUD0);
  __SET_VAR(data__->,_TMP_ADD92_OUT,,ADD__INT__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_VAR(data__->CTUD0.CV,),
    (INT)1));
  __SET_VAR(data__->,_TMP_MUL93_OUT,,MUL__INT__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_VAR(data__->_TMP_ADD92_OUT,),
    (INT)10));
  __SET_VAR(data__->,_TMP_ADD94_OUT,,ADD__INT__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_VAR(data__->_TMP_MUL93_OUT,),
    (INT)70));
  __SET_LOCATED(data__->,SETPOINT,,__GET_VAR(data__->_TMP_ADD94_OUT,));
  __SET_VAR(data__->,_TMP_EQ111_OUT,,EQ__BOOL__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)80,
    (INT)__GET_LOCATED(data__->SETPOINT,)));
  __SET_VAR(data__->,_TMP_EQ22_OUT,,EQ__BOOL__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_LOCATED(data__->SETPOINT,),
    (INT)90));
  __SET_LOCATED(data__->,LED0,,(__GET_VAR(data__->_TMP_EQ111_OUT,) || __GET_VAR(data__->_TMP_EQ22_OUT,)));
  __SET_VAR(data__->,_TMP_EQ11_OUT,,EQ__BOOL__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_LOCATED(data__->SETPOINT,),
    (INT)100));
  __SET_VAR(data__->,_TMP_EQ23_OUT,,EQ__BOOL__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_LOCATED(data__->SETPOINT,),
    (INT)110));
  __SET_LOCATED(data__->,LED1,,((__GET_VAR(data__->_TMP_EQ11_OUT,) || __GET_VAR(data__->_TMP_EQ22_OUT,)) || __GET_VAR(data__->_TMP_EQ23_OUT,)));
  __SET_VAR(data__->,_TMP_EQ31_OUT,,EQ__BOOL__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_LOCATED(data__->SETPOINT,),
    (INT)120));
  __SET_VAR(data__->,_TMP_EQ33_OUT,,EQ__BOOL__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_LOCATED(data__->SETPOINT,),
    (INT)130));
  __SET_LOCATED(data__->,LED2,,((__GET_VAR(data__->_TMP_EQ23_OUT,) || __GET_VAR(data__->_TMP_EQ31_OUT,)) || __GET_VAR(data__->_TMP_EQ33_OUT,)));
  __SET_VAR(data__->,_TMP_EQ41_OUT,,EQ__BOOL__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_LOCATED(data__->SETPOINT,),
    (INT)140));
  __SET_VAR(data__->,_TMP_EQ42_OUT,,EQ__BOOL__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_LOCATED(data__->SETPOINT,),
    (INT)150));
  __SET_LOCATED(data__->,LED3,,((__GET_VAR(data__->_TMP_EQ33_OUT,) || __GET_VAR(data__->_TMP_EQ41_OUT,)) || __GET_VAR(data__->_TMP_EQ42_OUT,)));
  __SET_VAR(data__->,_TMP_EQ46_OUT,,EQ__BOOL__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_LOCATED(data__->SETPOINT,),
    (INT)160));
  __SET_VAR(data__->,_TMP_EQ50_OUT,,EQ__BOOL__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_LOCATED(data__->SETPOINT,),
    (INT)170));
  __SET_LOCATED(data__->,LED4,,((__GET_VAR(data__->_TMP_EQ42_OUT,) || __GET_VAR(data__->_TMP_EQ46_OUT,)) || __GET_VAR(data__->_TMP_EQ50_OUT,)));
  __SET_VAR(data__->,_TMP_EQ51_OUT,,EQ__BOOL__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_LOCATED(data__->SETPOINT,),
    (INT)180));
  __SET_LOCATED(data__->,LED5,,(__GET_VAR(data__->_TMP_EQ50_OUT,) || __GET_VAR(data__->_TMP_EQ51_OUT,)));
  if (__GET_VAR(data__->E_STATE,)) {
    __SET_LOCATED(data__->,LED0,,__BOOL_LITERAL(FALSE));
  };
  if (__GET_VAR(data__->E_STATE,)) {
    __SET_LOCATED(data__->,LED1,,__BOOL_LITERAL(FALSE));
  };
  if (__GET_VAR(data__->E_STATE,)) {
    __SET_LOCATED(data__->,LED2,,__BOOL_LITERAL(FALSE));
  };
  if (__GET_VAR(data__->E_STATE,)) {
    __SET_LOCATED(data__->,LED3,,__BOOL_LITERAL(FALSE));
  };
  if (__GET_VAR(data__->E_STATE,)) {
    __SET_LOCATED(data__->,LED4,,__BOOL_LITERAL(FALSE));
  };
  if (__GET_VAR(data__->E_STATE,)) {
    __SET_LOCATED(data__->,LED5,,__BOOL_LITERAL(FALSE));
  };
  __SET_VAR(data__->,_TMP_INT_TO_REAL76_OUT,,INT_TO_REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (INT)__GET_LOCATED(data__->ANGLE,)));
  __SET_VAR(data__->PWM_CONTROLLER0.,CHANNEL,,1);
  __SET_VAR(data__->PWM_CONTROLLER0.,FREQ,,50.00);
  __SET_VAR(data__->PWM_CONTROLLER0.,DUTY,,__GET_VAR(data__->_TMP_INT_TO_REAL76_OUT,));
  PWM_CONTROLLER_body__(&data__->PWM_CONTROLLER0);
  __SET_VAR(data__->,_TMP_BOOL_TO_INT136_OUT,,BOOL_TO_INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (BOOL)__GET_VAR(data__->PWM_CONTROLLER0.SUCCESS,)));
  __SET_LOCATED(data__->,STATUS_PWM,,__GET_VAR(data__->_TMP_BOOL_TO_INT136_OUT,));
  __SET_VAR(data__->,_TMP_INT_TO_REAL135_OUT,,INT_TO_REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (INT)__GET_LOCATED(data__->VOLT,)));
  __SET_VAR(data__->,_TMP_DIV120_OUT,,DIV__REAL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->_TMP_INT_TO_REAL135_OUT,),
    (REAL)65535.0));
  __SET_VAR(data__->,_TMP_MUL121_OUT,,MUL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (REAL)__GET_VAR(data__->_TMP_DIV120_OUT,),
    (REAL)190.0));
  __SET_VAR(data__->,_TMP_REAL_TO_INT133_OUT,,REAL_TO_INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->_TMP_MUL121_OUT,)));
  __SET_VAR(data__->,_TMP_MUL173_OUT,,MUL__INT__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_VAR(data__->_TMP_REAL_TO_INT133_OUT,),
    (INT)10));
  __SET_LOCATED(data__->,ANGLE,,__GET_VAR(data__->_TMP_MUL173_OUT,));
  __SET_VAR(data__->,_TMP_BOOL_TO_INT163_OUT,,BOOL_TO_INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (BOOL)(((__GET_VAR(data__->RUN_STATE,) && !(__GET_LOCATED(data__->STOP_BTN,))) && __GET_LOCATED(data__->START_BTN,)) && !(__GET_LOCATED(data__->STOP_BTN,)))));
  __SET_LOCATED(data__->,STATUS_RUN,,__GET_VAR(data__->_TMP_BOOL_TO_INT163_OUT,));
  __SET_VAR(data__->,_TMP_INT_TO_REAL182_OUT,,INT_TO_REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (INT)__GET_LOCATED(data__->SETPOINT,)));
  __SET_VAR(data__->PID0.,AUTO,,__BOOL_LITERAL(TRUE));
  __SET_VAR(data__->PID0.,PV,,__GET_VAR(data__->CALCPOWER,));
  __SET_VAR(data__->PID0.,SP,,__GET_VAR(data__->_TMP_INT_TO_REAL182_OUT,));
  __SET_VAR(data__->PID0.,CYCLE,,__time_to_timespec(1, 100, 0, 0, 0, 0));
  PID_body__(&data__->PID0);
  __SET_VAR(data__->,_TMP_REAL_TO_INT180_OUT,,REAL_TO_INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->PID0.XOUT,)));
  __SET_LOCATED(data__->,POWER,,__GET_VAR(data__->_TMP_REAL_TO_INT180_OUT,));
  __SET_VAR(data__->,_TMP_MUL73_OUT,,MUL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (REAL)__GET_VAR(data__->_TMP_INT_TO_REAL135_OUT,),
    (REAL)3.3));
  __SET_VAR(data__->,_TMP_DIV70_OUT,,DIV__REAL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->_TMP_MUL73_OUT,),
    (REAL)65536.0));
  __SET_VAR(data__->,CALCPOWER,,__GET_VAR(data__->_TMP_DIV70_OUT,));
  __SET_VAR(data__->,CALCPOWER,,__GET_VAR(data__->PID0.XOUT,));
  __SET_VAR(data__->,_TMP_DIV191_OUT,,DIV__REAL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->CALCPOWER,),
    (REAL)3.3));
  __SET_VAR(data__->,_TMP_MUL192_OUT,,MUL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (REAL)__GET_VAR(data__->_TMP_DIV191_OUT,),
    (REAL)100.0));
  __SET_VAR(data__->,_TMP_REAL_TO_INT81_OUT,,REAL_TO_INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->_TMP_MUL192_OUT,)));
  __SET_LOCATED(data__->,POWER_PERCENT,,__GET_VAR(data__->_TMP_REAL_TO_INT81_OUT,));
  __SET_LOCATED(data__->,ACTUAL_TEMPERATURE,,__GET_LOCATED(data__->VOLT,));
  __SET_VAR(data__->,_TMP_REAL_TO_INT71_OUT,,REAL_TO_INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->_TMP_MUL73_OUT,)));
  __SET_LOCATED(data__->,VOLTMULCURRENT,,__GET_VAR(data__->_TMP_REAL_TO_INT71_OUT,));
  __SET_VAR(data__->,_TMP_REAL_TO_WORD72_OUT,,REAL_TO_WORD(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->_TMP_DIV70_OUT,)));
  __SET_LOCATED(data__->,POWER1,,__GET_VAR(data__->_TMP_REAL_TO_WORD72_OUT,));
  __SET_VAR(data__->,_TMP_DIV198_OUT,,DIV__REAL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->CALCPOWER,),
    (REAL)3.3));
  __SET_VAR(data__->,_TMP_MUL199_OUT,,MUL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (REAL)__GET_VAR(data__->_TMP_DIV198_OUT,),
    (REAL)-110.0));
  __SET_VAR(data__->,_TMP_ADD202_OUT,,ADD__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (REAL)__GET_VAR(data__->_TMP_MUL199_OUT,),
    (REAL)80.0));
  __SET_VAR(data__->,_TMP_REAL_TO_INT88_OUT,,REAL_TO_INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->_TMP_ADD202_OUT,)));
  __SET_LOCATED(data__->,CURRENT_TEMP,,__GET_VAR(data__->_TMP_REAL_TO_INT88_OUT,));

  goto __end;

__end:
  return;
} // WATERBOILER_body__() 





