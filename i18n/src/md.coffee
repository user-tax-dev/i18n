#!/usr/bin/env coffee

> ./transalte.js:Transalte
  ./lang_li.js
  @iuser/read
  @iuser/write

< (src, fp, exist_fp, path)=>
  transalte = Transalte src
  #await read
  console.log src, fp, exist_fp, path

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()

