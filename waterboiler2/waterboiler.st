PROGRAM waterboiler
  VAR
    STOPPED_STATE : BOOL;
    RUN_STATE : BOOL;
    E_STATE : BOOL;
  END_VAR
  VAR
    START_BTN AT %IX0.0 : BOOL;
    STOP_BTN AT %IX0.1 : BOOL;
    E_STOP AT %IX0.2 : BOOL;
    TEMP_UP AT %IX0.3 : BOOL;
    TEMP_DWN AT %IX0.4 : BOOL;
    P_SWITCH AT %IX0.5 : BOOL;
    HEATER AT %QX0.0 : BOOL;
    LED0 AT %QX0.1 : BOOL;
    LED1 AT %QX0.2 : BOOL;
    LED2 AT %QX0.3 : BOOL;
    LED3 AT %QX0.4 : BOOL;
    LED4 AT %QX0.5 : BOOL;
    LED5 AT %QX0.6 : BOOL;
    E_LED AT %QX0.7 : BOOL;
    SETPOINT AT %MW0 : INT := 80;
    DIAL_VALUE AT %IW0 : INT;
  END_VAR
  VAR
    SR0 : SR;
    R_TRIG0 : R_TRIG;
    R_TRIG1 : R_TRIG;
    CTUD0 : CTUD;
    PWM_CONTROLLER0 : PWM_CONTROLLER;
    SERVO_OK : BOOL;
  END_VAR
  VAR
    ANGLE AT %QW0 : INT;
  END_VAR
  VAR
    DUTY : REAL;
    R_TRIG2 : R_TRIG;
    R_TRIG3 : R_TRIG;
    R_TRIG4 : R_TRIG;
    _TMP_ADD92_OUT : INT;
    _TMP_MUL93_OUT : INT;
    _TMP_ADD94_OUT : INT;
    _TMP_EQ111_OUT : BOOL;
    _TMP_EQ22_OUT : BOOL;
    _TMP_EQ11_OUT : BOOL;
    _TMP_EQ23_OUT : BOOL;
    _TMP_EQ31_OUT : BOOL;
    _TMP_EQ33_OUT : BOOL;
    _TMP_EQ41_OUT : BOOL;
    _TMP_EQ42_OUT : BOOL;
    _TMP_EQ46_OUT : BOOL;
    _TMP_EQ50_OUT : BOOL;
    _TMP_EQ51_OUT : BOOL;
    _TMP_INT_TO_REAL77_OUT : REAL;
    _TMP_DIV120_OUT : REAL;
    _TMP_MUL121_OUT : REAL;
    _TMP_ADD173_OUT : REAL;
    _TMP_REAL_TO_INT180_OUT : INT;
    _TMP_INT_TO_REAL179_OUT : REAL;
    _TMP_DIV175_OUT : REAL;
    _TMP_MUL176_OUT : REAL;
    _TMP_ADD177_OUT : REAL;
  END_VAR

  RUN_STATE := (RUN_STATE OR START_BTN) AND NOT(STOP_BTN);
  STOPPED_STATE := NOT(E_STATE) AND NOT(RUN_STATE);
  HEATER := NOT(E_STATE) AND RUN_STATE;
  SR0(S1 := E_STOP AND RUN_STATE, R := STOP_BTN AND E_STOP AND E_STATE);
  E_STATE := SR0.Q1;
  E_LED := E_STATE;
  R_TRIG0(CLK := TEMP_UP AND NOT(E_STATE) AND NOT(RUN_STATE));
  R_TRIG3(CLK := R_TRIG0.Q);
  R_TRIG1(CLK := TEMP_DWN AND NOT(E_STATE) AND NOT(RUN_STATE));
  R_TRIG4(CLK := R_TRIG1.Q);
  R_TRIG2(CLK := E_STATE);
  CTUD0(CU := R_TRIG3.Q, CD := R_TRIG4.Q, R := R_TRIG2.Q, PV := 10);
  _TMP_ADD92_OUT := ADD(CTUD0.CV, 1);
  _TMP_MUL93_OUT := MUL(_TMP_ADD92_OUT, 10);
  _TMP_ADD94_OUT := ADD(_TMP_MUL93_OUT, 70);
  SETPOINT := _TMP_ADD94_OUT;
  _TMP_EQ111_OUT := EQ(80, SETPOINT);
  _TMP_EQ22_OUT := EQ(SETPOINT, 90);
  LED0 := _TMP_EQ111_OUT OR _TMP_EQ22_OUT;
  _TMP_EQ11_OUT := EQ(SETPOINT, 100);
  _TMP_EQ23_OUT := EQ(SETPOINT, 110);
  LED1 := _TMP_EQ11_OUT OR _TMP_EQ22_OUT OR _TMP_EQ23_OUT;
  _TMP_EQ31_OUT := EQ(SETPOINT, 120);
  _TMP_EQ33_OUT := EQ(SETPOINT, 130);
  LED2 := _TMP_EQ23_OUT OR _TMP_EQ31_OUT OR _TMP_EQ33_OUT;
  _TMP_EQ41_OUT := EQ(SETPOINT, 140);
  _TMP_EQ42_OUT := EQ(SETPOINT, 150);
  LED3 := _TMP_EQ33_OUT OR _TMP_EQ41_OUT OR _TMP_EQ42_OUT;
  _TMP_EQ46_OUT := EQ(SETPOINT, 160);
  _TMP_EQ50_OUT := EQ(SETPOINT, 170);
  LED4 := _TMP_EQ42_OUT OR _TMP_EQ46_OUT OR _TMP_EQ50_OUT;
  _TMP_EQ51_OUT := EQ(SETPOINT, 180);
  LED5 := _TMP_EQ50_OUT OR _TMP_EQ51_OUT;
  IF E_STATE THEN
    LED0 := FALSE; (*reset*)
  END_IF;
  IF E_STATE THEN
    LED1 := FALSE; (*reset*)
  END_IF;
  IF E_STATE THEN
    LED2 := FALSE; (*reset*)
  END_IF;
  IF E_STATE THEN
    LED3 := FALSE; (*reset*)
  END_IF;
  IF E_STATE THEN
    LED4 := FALSE; (*reset*)
  END_IF;
  IF E_STATE THEN
    LED5 := FALSE; (*reset*)
  END_IF;
  _TMP_INT_TO_REAL77_OUT := INT_TO_REAL(DIAL_VALUE);
  _TMP_DIV120_OUT := DIV(_TMP_INT_TO_REAL77_OUT, 65535.0);
  _TMP_MUL121_OUT := MUL(_TMP_DIV120_OUT, 190.0);
  _TMP_ADD173_OUT := ADD(_TMP_MUL121_OUT, 5.0);
  _TMP_REAL_TO_INT180_OUT := REAL_TO_INT(_TMP_ADD173_OUT);
  ANGLE := _TMP_REAL_TO_INT180_OUT;
  _TMP_INT_TO_REAL179_OUT := INT_TO_REAL(ANGLE);
  _TMP_DIV175_OUT := DIV(_TMP_INT_TO_REAL179_OUT, 190.0);
  _TMP_MUL176_OUT := MUL(_TMP_DIV175_OUT, 5.0);
  _TMP_ADD177_OUT := ADD(_TMP_MUL176_OUT, 5.0);
  DUTY := _TMP_ADD177_OUT;
  PWM_CONTROLLER0(CHANNEL := 0, FREQ := 50.00, DUTY := DUTY);
  SERVO_OK := PWM_CONTROLLER0.SUCCESS;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : waterboiler;
  END_RESOURCE
END_CONFIGURATION

(*DBG:char md5[] = "7fbb2040f9b4bb87708323e46592396a";*)
(*DBG:/**)
(*DBG: * This file is part of OpenPLC Runtime*)
(*DBG: **)
(*DBG: * Copyright (C) 2023 Autonomy, GP Orcullo*)
(*DBG: * Based on the work by GP Orcullo on Beremiz for uC*)
(*DBG: **)
(*DBG: * This program is free software; you can redistribute it and/or*)
(*DBG: * modify it under the terms of the GNU General Public License*)
(*DBG: * as published by the Free Software Foundation; either version 2*)
(*DBG: * of the License, or (at your option) any later version.*)
(*DBG: **)
(*DBG: * This program is distributed in the hope that it will be useful,*)
(*DBG: * but WITHOUT ANY WARRANTY; without even the implied warranty of*)
(*DBG: * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the*)
(*DBG: * GNU General Public License for more details.*)
(*DBG: **)
(*DBG: * You should have received a copy of the GNU General Public License*)
(*DBG: * along with this program; If not, see <http://www.gnu.org/licenses/>.*)
(*DBG: **)
(*DBG: */*)
(*DBG:*)
(*DBG:#include <stdbool.h>*)
(*DBG:*)
(*DBG:#include "iec_types_all.h"*)
(*DBG:#include "POUS.h"*)
(*DBG:*)
(*DBG:#define SAME_ENDIANNESS      0*)
(*DBG:#define REVERSE_ENDIANNESS   1*)
(*DBG:*)
(*DBG:uint8_t endianness;*)
(*DBG:*)
(*DBG:*)
(*DBG:extern WATERBOILER RES0__INSTANCE0;*)
(*DBG:*)
(*DBG:static const struct {*)
(*DBG:    void *ptr;*)
(*DBG:    __IEC_types_enum type;*)
(*DBG:} debug_vars[] = {*)
(*DBG:    {&(RES0__INSTANCE0.STOPPED_STATE), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.RUN_STATE), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.E_STATE), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.START_BTN), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.STOP_BTN), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.E_STOP), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TEMP_UP), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TEMP_DWN), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.P_SWITCH), BOOL_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.HEATER), BOOL_O_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.LED0), BOOL_O_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.LED1), BOOL_O_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.LED2), BOOL_O_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.LED3), BOOL_O_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.LED4), BOOL_O_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.LED5), BOOL_O_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.E_LED), BOOL_O_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.SETPOINT), INT_O_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.DIAL_VALUE), INT_P_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.SR0.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.SR0.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.SR0.S1), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.SR0.R), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.SR0.Q1), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG0.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG0.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG0.CLK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG0.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG0.M), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.CLK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.M), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.CU), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.CD), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.R), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.LD), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.PV), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.QU), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.QD), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.CV), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.CD_T.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.CD_T.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.CD_T.CLK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.CD_T.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.CD_T.M), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.CU_T.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.CU_T.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.CU_T.CLK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.CU_T.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTUD0.CU_T.M), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.PWM_CONTROLLER0.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.PWM_CONTROLLER0.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.PWM_CONTROLLER0.CHANNEL), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.PWM_CONTROLLER0.FREQ), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.PWM_CONTROLLER0.DUTY), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.PWM_CONTROLLER0.SUCCESS), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.PWM_CONTROLLER0.INTERNAL_CH), SINT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.PWM_CONTROLLER0.INTERNAL_FREQ), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.PWM_CONTROLLER0.INTERNAL_DUTY), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.SERVO_OK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.ANGLE), INT_O_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.DUTY), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG2.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG2.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG2.CLK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG2.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG2.M), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG3.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG3.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG3.CLK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG3.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG3.M), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG4.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG4.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG4.CLK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG4.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG4.M), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_ADD92_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_MUL93_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_ADD94_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_EQ111_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_EQ22_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_EQ11_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_EQ23_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_EQ31_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_EQ33_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_EQ41_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_EQ42_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_EQ46_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_EQ50_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_EQ51_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_INT_TO_REAL77_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_DIV120_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_MUL121_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_ADD173_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_REAL_TO_INT180_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_INT_TO_REAL179_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_DIV175_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_MUL176_OUT), REAL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_ADD177_OUT), REAL_ENUM},*)
(*DBG:};*)
(*DBG:*)
(*DBG:#define VAR_COUNT               104*)
(*DBG:*)
(*DBG:uint16_t get_var_count(void)*)
(*DBG:{*)
(*DBG:    return VAR_COUNT;*)
(*DBG:}*)
(*DBG:*)
(*DBG:size_t get_var_size(size_t idx)*)
(*DBG:{*)
(*DBG:    if (idx >= VAR_COUNT)*)
(*DBG:    {*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:    switch (debug_vars[idx].type) {*)
(*DBG:    case BOOL_ENUM:*)
(*DBG:    case BOOL_O_ENUM:*)
(*DBG:    case BOOL_P_ENUM:*)
(*DBG:        return sizeof(BOOL);*)
(*DBG:    case SINT_ENUM:*)
(*DBG:        return sizeof(SINT);*)
(*DBG:    case REAL_ENUM:*)
(*DBG:        return sizeof(REAL);*)
(*DBG:    case INT_ENUM:*)
(*DBG:    case INT_O_ENUM:*)
(*DBG:    case INT_P_ENUM:*)
(*DBG:        return sizeof(INT);*)
(*DBG:    default:*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void *get_var_addr(size_t idx)*)
(*DBG:{*)
(*DBG:    void *ptr = debug_vars[idx].ptr;*)
(*DBG:*)
(*DBG:    switch (debug_vars[idx].type) {*)
(*DBG:    case BOOL_ENUM:*)
(*DBG:        return (void *)&((__IEC_BOOL_t *) ptr)->value;*)
(*DBG:    case BOOL_O_ENUM:*)
(*DBG:    case BOOL_P_ENUM:*)
(*DBG:        return (void *)((((__IEC_BOOL_p *) ptr)->flags & __IEC_FORCE_FLAG) *)
(*DBG:                        ? &(((__IEC_BOOL_p *) ptr)->fvalue) *)
(*DBG:                        : ((__IEC_BOOL_p *) ptr)->value);*)
(*DBG:    case SINT_ENUM:*)
(*DBG:        return (void *)&((__IEC_SINT_t *) ptr)->value;*)
(*DBG:    case REAL_ENUM:*)
(*DBG:        return (void *)&((__IEC_REAL_t *) ptr)->value;*)
(*DBG:    case INT_ENUM:*)
(*DBG:        return (void *)&((__IEC_INT_t *) ptr)->value;*)
(*DBG:    case INT_O_ENUM:*)
(*DBG:    case INT_P_ENUM:*)
(*DBG:        return (void *)((((__IEC_INT_p *) ptr)->flags & __IEC_FORCE_FLAG) *)
(*DBG:                        ? &(((__IEC_INT_p *) ptr)->fvalue) *)
(*DBG:                        : ((__IEC_INT_p *) ptr)->value);*)
(*DBG:    default:*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void force_var(size_t idx, bool forced, void *val)*)
(*DBG:{*)
(*DBG:    void *ptr = debug_vars[idx].ptr;*)
(*DBG:*)
(*DBG:    if (forced) {*)
(*DBG:        size_t var_size = get_var_size(idx);*)
(*DBG:        switch (debug_vars[idx].type) {*)
(*DBG:        case BOOL_ENUM: {*)
(*DBG:            memcpy(&((__IEC_BOOL_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_BOOL_t *) ptr)->value = *((BOOL *) val);*)
(*DBG:            ((__IEC_BOOL_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case BOOL_O_ENUM: {*)
(*DBG:            memcpy((((__IEC_BOOL_p *) ptr)->value), val, var_size);*)
(*DBG:            //*(((__IEC_BOOL_p *) ptr)->value) = *((BOOL *) val);*)
(*DBG:            ((__IEC_BOOL_p *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case BOOL_P_ENUM: {*)
(*DBG:            memcpy(&((__IEC_BOOL_p *) ptr)->fvalue, val, var_size);*)
(*DBG:            //((__IEC_BOOL_p *) ptr)->fvalue = *((BOOL *) val);*)
(*DBG:            ((__IEC_BOOL_p *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case SINT_ENUM: {*)
(*DBG:            memcpy(&((__IEC_SINT_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_SINT_t *) ptr)->value = *((SINT *) val);*)
(*DBG:            ((__IEC_SINT_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case REAL_ENUM: {*)
(*DBG:            memcpy(&((__IEC_REAL_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_REAL_t *) ptr)->value = *((REAL *) val);*)
(*DBG:            ((__IEC_REAL_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case INT_ENUM: {*)
(*DBG:            memcpy(&((__IEC_INT_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_INT_t *) ptr)->value = *((INT *) val);*)
(*DBG:            ((__IEC_INT_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case INT_O_ENUM: {*)
(*DBG:            memcpy((((__IEC_INT_p *) ptr)->value), val, var_size);*)
(*DBG:            //*(((__IEC_INT_p *) ptr)->value) = *((INT *) val);*)
(*DBG:            ((__IEC_INT_p *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case INT_P_ENUM: {*)
(*DBG:            memcpy(&((__IEC_INT_p *) ptr)->fvalue, val, var_size);*)
(*DBG:            //((__IEC_INT_p *) ptr)->fvalue = *((INT *) val);*)
(*DBG:            ((__IEC_INT_p *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        default:*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:    } else {*)
(*DBG:        switch (debug_vars[idx].type) {*)
(*DBG:        case BOOL_ENUM:*)
(*DBG:            ((__IEC_BOOL_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case BOOL_O_ENUM:*)
(*DBG:        case BOOL_P_ENUM:*)
(*DBG:            ((__IEC_BOOL_p *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case SINT_ENUM:*)
(*DBG:            ((__IEC_SINT_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case REAL_ENUM:*)
(*DBG:            ((__IEC_REAL_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case INT_ENUM:*)
(*DBG:            ((__IEC_INT_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case INT_O_ENUM:*)
(*DBG:        case INT_P_ENUM:*)
(*DBG:            ((__IEC_INT_p *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        default:*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void swap_bytes(void *ptr, size_t size) *)
(*DBG:{*)
(*DBG:    uint8_t *bytePtr = (uint8_t *)ptr;*)
(*DBG:    size_t i;*)
(*DBG:    for (i = 0; i < size / 2; ++i) *)
(*DBG:    {*)
(*DBG:        uint8_t temp = bytePtr[i];*)
(*DBG:        bytePtr[i] = bytePtr[size - 1 - i];*)
(*DBG:        bytePtr[size - 1 - i] = temp;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void trace_reset(void)*)
(*DBG:{*)
(*DBG:    for (size_t i=0; i < VAR_COUNT; i++) *)
(*DBG:    {*)
(*DBG:        force_var(i, false, 0);*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void set_trace(size_t idx, bool forced, void *val)*)
(*DBG:{*)
(*DBG:    if (idx >= 0 && idx < VAR_COUNT) *)
(*DBG:    {*)
(*DBG:        if (endianness == REVERSE_ENDIANNESS)*)
(*DBG:        {*)
(*DBG:            // Aaaaarghhhh... Stupid AVR is Big Endian.*)
(*DBG:            swap_bytes(val, get_var_size(idx));*)
(*DBG:        }*)
(*DBG:*)
(*DBG:        force_var(idx, forced, val);*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void set_endianness(uint8_t value)*)
(*DBG:{*)
(*DBG:    if (value == SAME_ENDIANNESS || value == REVERSE_ENDIANNESS)*)
(*DBG:    {*)
(*DBG:        endianness = value;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)