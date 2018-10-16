; REQUIRES: object-emission

; RUN: %llc_dwarf -O0 -filetype=obj < %s > %t
; RUN: llvm-dwarfdump -v -debug-info %t | FileCheck %s

; Check that interface types and inheritance work.

; CHECK: DW_TAG_structure_type
;  CHECK-NOT: TAG
;  CHECK: DW_AT_name [DW_FORM_strp]	( .debug_str[{{.*}}] = "F")
;  CHECK: DW_AT_byte_size [DW_FORM_data1]	(0x10)
;  CHECK: DW_AT_alignment [DW_FORM_udata]	(8)
;  CHECK: DW_TAG_inheritance
;    CHECK: DW_AT_type [DW_FORM_ref4]	(cu + {{.*}} => {{.*}} "Interface")
; CHECK: DW_TAG_interface_type
;   CHECK: DW_AT_name [DW_FORM_strp]	( .debug_str[{{.*}}] = "Interface")
;   CHECK-NOT: DW_AT_byte_size

%F = type { [0 x i8], {}*, [8 x i8] }
%"F::Nope" = type {}

define internal void @_ZN2e34main17h934ff72f9a38d4bbE() unnamed_addr #0 !dbg !5 {
start:
  %qq = alloca %F, align 8
  call void @llvm.dbg.declare(metadata %F* %qq, metadata !10, metadata !28), !dbg !29
  %0 = bitcast %F* %qq to {}**, !dbg !29
  store {}* null, {}** %0, !dbg !29
  %1 = bitcast %F* %qq to %"F::Nope"*, !dbg !29
  ret void, !dbg !30
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #0

attributes #0 = { nounwind uwtable }

!llvm.module.flags = !{!0, !1}
!llvm.dbg.cu = !{!2}

!0 = !{i32 1, !"PIE Level", i32 2}
!1 = !{i32 2, !"Debug Info Version", i32 3}
!2 = distinct !DICompileUnit(language: DW_LANG_Rust, file: !3, producer: "clang LLVM (rustc version 1.24.0-dev)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4)
!3 = !DIFile(filename: "e3.rs", directory: "/home/tromey/Rust")
!4 = !{}
!5 = distinct !DISubprogram(name: "main", linkageName: "_ZN2e34mainE", scope: !6, file: !3, line: 2, type: !8, isLocal: true, isDefinition: true, scopeLine: 2, flags: DIFlagPrototyped | DIFlagMainSubprogram, isOptimized: false, unit: !2, templateParams: !4, retainedNodes: !4)
!6 = !DINamespace(name: "e3", scope: null)
!7 = !DIFile(filename: "<unknown>", directory: "")
!8 = !DISubroutineType(types: !9)
!9 = !{null}
!10 = !DILocalVariable(name: "qq", scope: !11, file: !3, line: 3, type: !12, align: 8)
!11 = distinct !DILexicalBlock(scope: !5, file: !3, line: 3, column: 4)
!12 = !DICompositeType(tag: DW_TAG_structure_type, name: "F", scope: !6, file: !7, size: 128, align: 64, elements: !13, identifier: "7ce1efff6b82281ab9ceb730566e7e20")
!13 = !{!14}
!14 = !DIDerivedType(tag: DW_TAG_inheritance, scope: !12, baseType: !15)
!15 = !DICompositeType(tag: DW_TAG_interface_type, name: "Interface", scope: !6)
!28 = !DIExpression()
!29 = !DILocation(line: 3, scope: !11)
!30 = !DILocation(line: 4, scope: !5)
