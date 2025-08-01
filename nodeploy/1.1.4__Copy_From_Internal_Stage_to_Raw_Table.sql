use role sysadmin;
use database cricket;
use schema raw;
copy into cricket.raw.MATCH_RAW_TBL 
from(
   select 
   t.$1:meta::variant as meta,
   t.$1:info::variant as info,
   t.$1:innings::array as innings,
   metadata$filename as file_name,
   metadata$file_row_number::int as file_row_number,
   metadata$file_content_key::text as file_content_key,
   metadata$file_last_modified::text as stg_modified_ts
   FROM @CRICKET.LAND.CRICKET_STG (file_format => 'LAND.JSON_FORMAT') t
)
   on_error = ABORT_STATEMENT;
