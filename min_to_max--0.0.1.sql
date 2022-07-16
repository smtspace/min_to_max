/* TRANSITION FUNCTION */

-- integer
create or replace function min_to_max_tfunc (resarr bigint[], nextval bigint)
   returns bigint[]
  language plpgsql strict
as $$
declare temparr bigint[];
begin
    temparr[1] = least(nextval::bigint, resarr[1]);
    temparr[2] = greatest(nextval::bigint, resarr[2]);
    return temparr;
end;
$$;

-- float8
create or replace function min_to_max_tfunc (resarr float8[], nextval float8)
   returns float8[]
  language plpgsql strict
as $$
declare temparr float8[];
begin
    temparr[1] = least(nextval, resarr[1]);
    temparr[2] = greatest(nextval, resarr[2]);
    return temparr;
end;
$$;

-- char, varchar, text
create or replace function min_to_max_tfunc (resarr text[], nextval text)
   returns text[]
  language plpgsql strict
as $$
declare temparr text[];
begin
    temparr[1] = least(nextval::text, resarr[1]);
    temparr[2] = greatest(nextval::text, resarr[2]);
    return temparr;
end;
$$;


-- date
create or replace function min_to_max_tfunc (resarr date[], nextval date)
   returns date[]
  language plpgsql strict
as $$
declare temparr date[];
begin
    temparr[1] = least(nextval, resarr[1]);
    temparr[2] = greatest(nextval, resarr[2]);
    return temparr;
end;
$$;


-- timestamp
create or replace function min_to_max_tfunc (resarr timestamp[], nextval timestamp)
   returns timestamp[]
  language plpgsql strict
as $$
declare temparr timestamp[];
begin
    temparr[1] = least(nextval, resarr[1]);
    temparr[2] = greatest(nextval, resarr[2]);
    return temparr;
end;
$$;






/* FINAL FUNCTION */
-- integer
create or replace function min_to_max_ffunc (resarr bigint[])
   returns text
  language plpgsql strict
as $$
declare finalagg int[] = '{null,null}';
begin
        finalagg[1] = resarr[1]::int;
        finalagg[2] = resarr[2]::int;

     return finalagg[1] || ' -> ' || finalagg[2];
end;
$$;

-- float8
create or replace function min_to_max_ffunc (resarr float8[])
   returns text
  language plpgsql strict
as $$
declare finalagg float8[] = '{null,null}';
begin
        finalagg[1] = resarr[1];
        finalagg[2] = resarr[2];

     return finalagg[1] || ' -> ' || finalagg[2];
end;
$$;

-- char, varchar, text
create or replace function min_to_max_ffunc (resarr text[])
   returns text
  language plpgsql strict
as $$
declare finalagg text[] = '{null,null}';
begin
        finalagg[1] = resarr[1]::text;
        finalagg[2] = resarr[2]::text;

     return finalagg[1] || ' -> ' || finalagg[2];
end;
$$;

-- date
create or replace function min_to_max_ffunc (resarr date[])
   returns text
  language plpgsql strict
as $$
declare finalagg date[] = '{null,null}';
begin
        finalagg[1] = resarr[1];
        finalagg[2] = resarr[2];

     return finalagg[1] || ' -> ' || finalagg[2];
end;
$$;

-- timestamp
create or replace function min_to_max_ffunc (resarr timestamp[])
   returns text
  language plpgsql strict
as $$
declare finalagg timestamp[] = '{null,null}';
begin
        finalagg[1] = resarr[1];
        finalagg[2] = resarr[2];

     return finalagg[1] || ' -> ' || finalagg[2];
end;
$$;






/* AGGREGATION ITSELF */
-- integer
create or replace  aggregate  min_to_max (p_val bigint)
    (
      sfunc = min_to_max_tfunc
    , stype = bigint[]
    , finalfunc = min_to_max_ffunc
    , initcond = '{2147483648, -2147483649}'
    );

-- float8
create or replace  aggregate  min_to_max (p_val float8)
    (
      sfunc = min_to_max_tfunc
    , stype = float8[]
    , finalfunc = min_to_max_ffunc
    , initcond = '{2147483648, -2147483649}'
    );

-- char, varchar, text
create or replace  aggregate  min_to_max (p_val text)
    (
      sfunc = min_to_max_tfunc
    , stype = text[]
    , finalfunc = min_to_max_ffunc
    , initcond = '{null, null}'
    );

-- date
create or replace  aggregate  min_to_max (p_val date)
    (
      sfunc = min_to_max_tfunc
    , stype = date[]
    , finalfunc = min_to_max_ffunc
    , initcond = '{null, null}'
    );

-- timestamp
create or replace  aggregate  min_to_max (p_val timestamp)
    (
      sfunc = min_to_max_tfunc
    , stype = timestamp[]
    , finalfunc = min_to_max_ffunc
    , initcond = '{null, null}'
    );

