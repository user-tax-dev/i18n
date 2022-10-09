#!/usr/bin/env coffee

> ./transalte.js:Transalte
  ./lang_li.js
  @iuser/read
  fs > readFileSync existsSync
  @iuser/xxhash3-wasm > hash128
  @iuser/write
  @iuser/u8 > u8eq

str2id = (s)=>
  n = -1
  map = new Map()
  [
    s.replace(
      /(\${[a-zA-Z_]+})/g
      (a)=>
        map.set(++n, a[2..-2])
        '_'+n+'_'
    )
    map
  ]

id2str = (s,m)=>
  s.replaceAll('__','_')
   .replace(
     /(_\d+):/g
    (id)=>
      id[..-2]+'_ :'
   )
   .replace(
     /(_ \d+)/g
    (id)=>
      '_'+id[1..].trim()
   )
   .replace(
     /(\d+ _)/g
    (id)=>
      id[..-2].trim()+'_'
   )
   .replace(
     /(_\d+)$/mg
     (id)=>
      id.trimEnd()+'_'
   )
   .replace(
     /(^\d+_)/mg
     (id)=>
       '_'+id.trimStart()
   )
   .replace(
     /(_\d+ )/g
     (id)=>
      id.trimEnd()+'_ '
   )
   .replace(
     /( \d+_)/g
     (id)=>
       ' _'+id.trimStart()
   )
   .replace(
    /(_\d+_)/g
    (id)=>
      ' ${'+m.get(
        parseInt id[1...-1]
      )+'} '
  ).replace(
    / +/g
    ' '
  )

< (src, fp, exist_fp, path)=>
  src_fp = path src, fp
  txt = read(src_fp)
  hash = hash128 txt
  if existsSync exist_fp
    if u8eq hash, readFileSync(exist_fp)
      return

  transalte = Transalte src
  [md,map] = str2id txt
  for to from LangLi
    if to == src
      continue
    console.log to
    write(
      path(to, fp)
      (await transalte(to, [md])).map (s)=>
        id2str(s,map)
    )
  write(
    exist_fp
    hash
  )
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()

