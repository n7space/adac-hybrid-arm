-- This file is part of the adac-hybrid-arm distribution
-- Copyright (C) 2020, European Space Agency
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, version 3.
--
-- This program is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
-- General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program. If not, see <http://www.gnu.org/licenses/>.

with utils;
use utils;

package body reporting is

    procedure Init is
    begin
        -- NOP, can hooked up in a debugger
        return;
    end Init;

    procedure ReportError(errorNo : in Integer) is
    begin
        -- NOP, can hooked up in a debugger
        return;
    end ReportError;

    procedure ReportErrorString(error : in String) is
    begin
       -- NOP, can hooked up in a debugger
       return;
    end ReportErrorString;

    procedure ReportInfo(msg : in String) is
    begin
       -- NOP, can hooked up in a debugger
       return;
    end ReportInfo;

    procedure ReportSuccess is
    begin
        -- NOP, can hooked up in a debugger
        return;
    end ReportSuccess;

end reporting;
