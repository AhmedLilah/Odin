package main

import "core:fmt"

Untagged :: union { int, f32 } // C-style, no field names => untagged

Tagged   :: union {int, f32} // Field names => tagged

main :: proc() {
	fmt.println("--- Untagged Union ---");

	u: Untagged;
	u = transmute(Untagged)@42; // stores an int (manually)

	// ⚠️ Unsafe: no type info!
	fmt.println("Untagged as int:   {}", transmute(int)u);
	fmt.println("Untagged as float: {}", transmute(f32)u); // UB: same bytes interpreted as float

	fmt.println();
	fmt.println("--- Tagged Union ---");

	t: Tagged = Tagged{F = 3.14};

	// ✅ Safe: compiler tracks which field is active
	switch t {
	case .I:
		fmt.println("Tagged holds int: {}", t.I);
	case .F:
		fmt.println("Tagged holds float: {}", t.F);
	}

	// Type introspection
	fmt.println();
	fmt.println("--- Tagged Introspection ---");
	fmt.println("Size of Untagged: {} bytes", size_of(Untagged));
	fmt.println("Size of Tagged:   {} bytes", size_of(Tagged));
}
