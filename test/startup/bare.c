/**
 * \file
 *
 * \brief GCC startup file for bare bone MCU
 *
 * Copyright (c) 2017 Atmel Corporation, a wholly owned subsidiary of Microchip
 * Technology Inc.
 *
 * \license_start
 *
 * \page License
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * \license_stop
 *
 */

// Gathering coverage from startup procedure is not possible with GCOV
// (some of its procedures starts later)
// LCOV_EXCL_START

#include <stdint.h>
#include <stddef.h>

/* Initialize segments */
extern uint32_t _sfixed;
extern uint32_t _efixed;
extern uint32_t _etext;
extern uint32_t _srelocate;
extern uint32_t _erelocate;
extern uint32_t _szero;
extern uint32_t _ezero;
extern uint32_t _sstack;
extern uint32_t _estack;

/** \cond DOXYGEN_SHOULD_SKIP_THIS */
int main(void);
/** \endcond */

void __libc_init_array(void);

/* Reset handler */
void Reset_Handler(void);

/* Default empty handler */
void Dummy_Handler(void);

/* Cortex-M7 core handlers */
// clang-format off
void NMI_Handler              ( void ) __attribute__ ((weak, alias("Dummy_Handler")));
void HardFault_Handler        ( void ) __attribute__ ((weak, alias("Dummy_Handler")));
void MemManage_Handler        ( void ) __attribute__ ((weak, alias("Dummy_Handler")));
void BusFault_Handler         ( void ) __attribute__ ((weak, alias("Dummy_Handler")));
void UsageFault_Handler       ( void ) __attribute__ ((weak, alias("Dummy_Handler")));
void SVC_Handler              ( void ) __attribute__ ((weak, alias("Dummy_Handler")));
void DebugMon_Handler         ( void ) __attribute__ ((weak, alias("Dummy_Handler")));
void PendSV_Handler           ( void ) __attribute__ ((weak, alias("Dummy_Handler")));
void SysTick_Handler          ( void ) __attribute__ ((weak, alias("Dummy_Handler")));
// clang-format on

/// \brief A typedef for a function that can be used to register an interrupt
/// handler.
typedef void (*Nvic_InterruptHandler)(void);

typedef struct {
	/* Stack pointer */
	void *pvStack;

	/* Cortex-M handlers */
	Nvic_InterruptHandler pfnReset_Handler;
	Nvic_InterruptHandler pfnNMI_Handler;
	Nvic_InterruptHandler pfnHardFault_Handler;
	Nvic_InterruptHandler pfnMemManage_Handler;
	Nvic_InterruptHandler pfnBusFault_Handler;
	Nvic_InterruptHandler pfnUsageFault_Handler;
	Nvic_InterruptHandler pfnReserved1_Handler;
	Nvic_InterruptHandler pfnReserved2_Handler;
	Nvic_InterruptHandler pfnReserved3_Handler;
	Nvic_InterruptHandler pfnReserved4_Handler;
	Nvic_InterruptHandler pfnSVC_Handler;
	Nvic_InterruptHandler pfnDebugMon_Handler;
	Nvic_InterruptHandler pfnReserved5_Handler;
	Nvic_InterruptHandler pfnPendSV_Handler;
	Nvic_InterruptHandler pfnSysTick_Handler;
} DeviceVectors;

/* Exception Table */
__attribute__((section(".vectors"))) const DeviceVectors exception_table = {
	// clang-format off

  /* Configure Initial Stack Pointer, using linker-generated symbols */
  .pvStack = (void*) (&_estack),

  .pfnReset_Handler              = Reset_Handler,
  .pfnNMI_Handler                = NMI_Handler,
  .pfnHardFault_Handler          = HardFault_Handler,
  .pfnMemManage_Handler          = MemManage_Handler,
  .pfnBusFault_Handler           = BusFault_Handler,
  .pfnUsageFault_Handler         = UsageFault_Handler,
  .pfnReserved1_Handler          = 0uL, /* Reserved */
  .pfnReserved2_Handler          = 0uL, /* Reserved */
  .pfnReserved3_Handler          = 0uL, /* Reserved */
  .pfnReserved4_Handler          = 0uL, /* Reserved */
  .pfnSVC_Handler                = SVC_Handler,
  .pfnDebugMon_Handler           = DebugMon_Handler,
  .pfnReserved5_Handler          = 0uL, /* Reserved */
  .pfnPendSV_Handler             = PendSV_Handler,
  .pfnSysTick_Handler             = Dummy_Handler,
	// clang-format on
};

extern void (*__preinit_array_start[])(void) __attribute__((weak));
extern void (*__preinit_array_end[])(void) __attribute__((weak));
extern void (*__init_array_start[])(void) __attribute__((weak));
extern void (*__init_array_end[])(void) __attribute__((weak));

void _init(void); // provided by libgcc

static void
execute_init_array(void)
{
	const ptrdiff_t preinit_count =
			__preinit_array_end - __preinit_array_start;
	for (ptrdiff_t i = 0; i < preinit_count; i++)
		__preinit_array_start[i]();

	_init();

	const ptrdiff_t init_count = __init_array_end - __init_array_start;
	for (ptrdiff_t i = 0; i < init_count; i++)
		__init_array_start[i]();
}

/**
 * \brief This is the code that gets called on processor reset.
 * To initialize the device, and call the main() routine.
 */
void
Reset_Handler(void)
{
	/* Initialize the relocate segment */
	uint32_t *pSrc = &_etext;
	uint32_t *pDest = &_srelocate;

	if (pSrc != pDest) {
		for (; pDest < &_erelocate; pDest++, pSrc++) {
			*pDest = *pSrc;
		}
	}

	/* Clear the zero segment */
	for (pDest = &_szero; pDest < &_ezero; pDest++) {
		*pDest = 0;
	}

	/* Initialize ctors */
	execute_init_array();

	/* Branch to main function */
	main();

	/* Infinite loop */
	while (1)
		;
}

/**
 * \brief Default interrupt handler for unused IRQs.
 */
void
Dummy_Handler(void)
{
	/* Infinite loop */
	while (1)
		;
}

// LCOV_EXCL_STOP
