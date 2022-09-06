#!/usr/bin/env coffee

> await-sleep:sleep
  @iuser/google-translate-api:translate
# ../i18n.js > I18nClient
# path > join
# util > promisify
#@grpc/grpc-js:grpc
#client = new I18nClient("127.0.0.1:5900",  grpc.credentials.createInsecure())


rename = {
  zh:'zh-CN'
  fil:'tl'
}

< (src)=>
  src = rename[src] or src
  (to, li)=>
    to = rename[to] or to
    result = []
    if li.length
      for i from li
        retry = 9
        loop
          try
            r = await translate(i, {from: src, to, tld:'cn'})
            result.push r.text
            break
          catch err
            if retry
              --retry
              console.error err
              console.trace to, src, i
              await sleep 3000
            else
              throw err
            await sleep 100
    result

