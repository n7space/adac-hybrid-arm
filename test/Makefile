## This file is part of the adac-hybrid-arm distribution
## Copyright (C) 2022, European Space Agency
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, version 3.
##
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program. If not, see <http://www.gnu.org/licenses/>.

# asn1scc/rtl and asn1scc/rtl2 do not work with AdaCore's arm-eabi-gcc

TESTS = \
	adainterop \
	ads \
	cinterop \
	floatmath \
	gpr \
	intmath \
	opengeode/basicsdl \
	opengeode/managemode

.PHONY: $(TESTS) test clean

# Wrapper to invoke each of the goals from TESTS
# The actual goal (test) of the invocation will be passed via MAKECMDGOALDS
test: $(TESTS)

# Wrapper to invoke each of the goals from TESTS
# The actual goal (clean) of the invocation will be passed via MAKECMDGOALDS
clean: $(TESTS)

# For each goal (test folder) in TESTS, invoke make,
# passing the high-level goal (test or clean)
$(TESTS):
	$(MAKE) -C $@ $(MAKECMDGOALS)
