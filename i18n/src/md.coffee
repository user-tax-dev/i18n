#!/usr/bin/env coffee

> ./transalte.js:Transalte
  ./lang_li.js
  @iuser/read
  fs > readFileSync
  @iuser/write

< (src, fp, exist_fp, path)=>
  transalte = Transalte src
  src_fp = path src, fp
  md = read(src_fp)
  console.log src_fp
  for to from LangLi
    await write(
      path(to, fp)
      await transalte(to, [md])
    )
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()

