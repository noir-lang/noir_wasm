/* tslint:disable */
/* eslint-disable */
/**
* @param {any} args
* @returns {any}
*/
export function compile(args: any): any;
/**
* @param {Uint8Array} bytes
* @returns {any}
*/
export function acir_read_bytes(bytes: Uint8Array): any;
/**
* @param {any} acir
* @returns {Uint8Array}
*/
export function acir_write_bytes(acir: any): Uint8Array;
/**
* @param {string} level
*/
export function init_log_level(level: string): void;
/**
* @returns {any}
*/
export function build_info(): any;
/**
* A struct representing a Trap
*/
export class Trap {
  free(): void;
/**
* @returns {Symbol}
*/
  static __wbgd_downcast_token(): Symbol;
}

export type InitInput = RequestInfo | URL | Response | BufferSource | WebAssembly.Module;

export interface InitOutput {
  readonly memory: WebAssembly.Memory;
  readonly compile: (a: number) => number;
  readonly acir_read_bytes: (a: number, b: number) => number;
  readonly acir_write_bytes: (a: number, b: number) => void;
  readonly init_log_level: (a: number, b: number) => void;
  readonly build_info: () => number;
  readonly rust_psm_on_stack: (a: number, b: number, c: number, d: number) => void;
  readonly rust_psm_stack_direction: () => number;
  readonly rust_psm_stack_pointer: () => number;
  readonly rust_psm_replace_stack: (a: number, b: number, c: number) => void;
  readonly __wbg_trap_free: (a: number) => void;
  readonly trap___wbgd_downcast_token: () => number;
  readonly __wbindgen_export_0: (a: number) => number;
  readonly __wbindgen_export_1: (a: number, b: number, c: number) => number;
  readonly __wbindgen_add_to_stack_pointer: (a: number) => number;
  readonly __wbindgen_export_2: (a: number, b: number) => void;
  readonly __wbindgen_export_3: (a: number) => void;
}

export type SyncInitInput = BufferSource | WebAssembly.Module;
/**
* Instantiates the given `module`, which can either be bytes or
* a precompiled `WebAssembly.Module`.
*
* @param {SyncInitInput} module
*
* @returns {InitOutput}
*/
export function initSync(module: SyncInitInput): InitOutput;

/**
* If `module_or_path` is {RequestInfo} or {URL}, makes a request and
* for everything else, calls `WebAssembly.instantiate` directly.
*
* @param {InitInput | Promise<InitInput>} module_or_path
*
* @returns {Promise<InitOutput>}
*/
export default function __wbg_init (module_or_path?: InitInput | Promise<InitInput>): Promise<InitOutput>;
