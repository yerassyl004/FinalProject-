/* This file was generated by upbc (the upb compiler) from the input
 * file:
 *
 *     envoy/admin/v3/init_dump.proto
 *
 * Do not edit -- your changes will be discarded when the file is
 * regenerated. */

#include <stddef.h>
#include "upb/msg_internal.h"
#include "envoy/admin/v3/init_dump.upb.h"
#include "udpa/annotations/status.upb.h"

#include "upb/port_def.inc"

static const upb_MiniTable_Sub envoy_admin_v3_UnreadyTargetsDumps_submsgs[1] = {
  {.submsg = &envoy_admin_v3_UnreadyTargetsDumps_UnreadyTargetsDump_msginit},
};

static const upb_MiniTable_Field envoy_admin_v3_UnreadyTargetsDumps__fields[1] = {
  {1, UPB_SIZE(0, 0), UPB_SIZE(0, 0), 0, 11, kUpb_FieldMode_Array | (kUpb_FieldRep_Pointer << kUpb_FieldRep_Shift)},
};

const upb_MiniTable envoy_admin_v3_UnreadyTargetsDumps_msginit = {
  &envoy_admin_v3_UnreadyTargetsDumps_submsgs[0],
  &envoy_admin_v3_UnreadyTargetsDumps__fields[0],
  UPB_SIZE(8, 8), 1, kUpb_ExtMode_NonExtendable, 1, 255, 0,
};

static const upb_MiniTable_Field envoy_admin_v3_UnreadyTargetsDumps_UnreadyTargetsDump__fields[2] = {
  {1, UPB_SIZE(0, 0), UPB_SIZE(0, 0), kUpb_NoSub, 9, kUpb_FieldMode_Scalar | (kUpb_FieldRep_StringView << kUpb_FieldRep_Shift)},
  {2, UPB_SIZE(8, 16), UPB_SIZE(0, 0), kUpb_NoSub, 9, kUpb_FieldMode_Array | (kUpb_FieldRep_Pointer << kUpb_FieldRep_Shift)},
};

const upb_MiniTable envoy_admin_v3_UnreadyTargetsDumps_UnreadyTargetsDump_msginit = {
  NULL,
  &envoy_admin_v3_UnreadyTargetsDumps_UnreadyTargetsDump__fields[0],
  UPB_SIZE(16, 24), 2, kUpb_ExtMode_NonExtendable, 2, 255, 0,
};

static const upb_MiniTable *messages_layout[2] = {
  &envoy_admin_v3_UnreadyTargetsDumps_msginit,
  &envoy_admin_v3_UnreadyTargetsDumps_UnreadyTargetsDump_msginit,
};

const upb_MiniTable_File envoy_admin_v3_init_dump_proto_upb_file_layout = {
  messages_layout,
  NULL,
  NULL,
  2,
  0,
  0,
};

#include "upb/port_undef.inc"
