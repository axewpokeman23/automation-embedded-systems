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
  END_VAR
  VAR
    SETPOINT : INT := 80;
  END_VAR
  VAR CONSTANT
    SETPOINT_CHANGE : INT := 10;
    MIN_TEMP : INT := 80;
    MAX_TEMP : INT := 180;
  END_VAR
  VAR
    TEMP_DIAL : BOOL;
    SERVO : BOOL;
    SR0 : SR;
    UP_TRIG : R_TRIG;
    DWN_TRIG : R_TRIG;
  END_VAR
  VAR CONSTANT
    TEMP_80 : INT := 80;
  END_VAR
  VAR
    _TMP_EQ87_OUT : BOOL;
    _TMP_LT80_OUT : BOOL;
    _TMP_ADD72_ENO : BOOL;
    _TMP_ADD72_OUT : INT;
    _TMP_GT84_OUT : BOOL;
    _TMP_SUB85_ENO : BOOL;
    _TMP_SUB85_OUT : INT;
  END_VAR

  RUN_STATE := (RUN_STATE OR START_BTN) AND NOT(STOP_BTN);
  STOPPED_STATE := NOT(E_STATE) AND NOT(RUN_STATE);
  HEATER := NOT(E_STATE) AND RUN_STATE;
  SR0(S1 := E_STOP AND RUN_STATE, R := STOP_BTN AND E_STOP AND E_STATE);
  E_STATE := SR0.Q1;
  E_LED := E_STATE;
  _TMP_EQ87_OUT := EQ(SETPOINT, TEMP_80);
  LED0 := TRUE;
  _TMP_LT80_OUT := LT(SETPOINT, MAX_TEMP);
  UP_TRIG(CLK := TEMP_UP AND STOPPED_STATE);
  _TMP_ADD72_OUT := ADD(EN := UP_TRIG.Q OR _TMP_LT80_OUT, IN1 := SETPOINT, IN2 := SETPOINT_CHANGE, ENO => _TMP_ADD72_ENO);
  IF _TMP_ADD72_ENO THEN
      SETPOINT := _TMP_ADD72_OUT;
  END_IF;
  _TMP_GT84_OUT := GT(SETPOINT, MIN_TEMP);
  DWN_TRIG(CLK := TEMP_DWN AND STOPPED_STATE);
  _TMP_SUB85_OUT := SUB(EN := DWN_TRIG.Q OR _TMP_GT84_OUT, IN1 := SETPOINT, IN2 := SETPOINT_CHANGE, ENO => _TMP_SUB85_ENO);
  IF _TMP_SUB85_ENO THEN
      SETPOINT := _TMP_SUB85_OUT;
  END_IF;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : waterboiler;
  END_RESOURCE
END_CONFIGURATION

(*DBG:char md5[] = "6e33c1dacbe957e667c850c3caf405c3";*)
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
(*DBG:    {&(RES0__INSTANCE0.SETPOINT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.SETPOINT_CHANGE), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.MIN_TEMP), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.MAX_TEMP), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TEMP_DIAL), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.SERVO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.SR0.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.SR0.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.SR0.S1), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.SR0.R), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.SR0.Q1), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.UP_TRIG.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.UP_TRIG.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.UP_TRIG.CLK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.UP_TRIG.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.UP_TRIG.M), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.DWN_TRIG.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.DWN_TRIG.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.DWN_TRIG.CLK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.DWN_TRIG.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.DWN_TRIG.M), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TEMP_80), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_EQ87_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_LT80_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_ADD72_ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_ADD72_OUT), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_GT84_OUT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_SUB85_ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0._TMP_SUB85_OUT), INT_ENUM},*)
(*DBG:};*)
(*DBG:*)
(*DBG:#define VAR_COUNT               46*)
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
(*DBG:    case INT_ENUM:*)
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
(*DBG:    case INT_ENUM:*)
(*DBG:        return (void *)&((__IEC_INT_t *) ptr)->value;*)
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
(*DBG:        case INT_ENUM: {*)
(*DBG:            memcpy(&((__IEC_INT_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_INT_t *) ptr)->value = *((INT *) val);*)
(*DBG:            ((__IEC_INT_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
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
(*DBG:        case INT_ENUM:*)
(*DBG:            ((__IEC_INT_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
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