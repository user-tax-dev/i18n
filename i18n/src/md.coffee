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
  console.log md
  for to from LangLi
    console.log to
    #console.log await transalte(to, [md])
    await write(
      path(to, fp)
      ""
    )
    break
  # md = await read fp

  #console.log src, fp, exist_fp, path

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()

