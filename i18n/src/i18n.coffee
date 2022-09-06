#!/usr/bin/env coffee

> ./lang_li.js
  ./index.js:i18n
  @iuser/walk > walkRel
  fs > writeFileSync mkdirSync readFileSync statSync existsSync
  path > resolve
  yargs/helpers > hideBin
  yargs/yargs

argv = yargs(hideBin(process.argv))
  .alias('d', 'dir')
  .describe('dir', 'worker dir ( default is pwd )')
  .demandCommand(1,1,'i18n [src_lang]')
  .parse()

{exit} = process
{error} = console

[lang] = argv._

if lang_li.indexOf(lang) < 0
  error lang + ' not in { ' + [...lang_li].join(' ')+' }'
  exit(1)

{dir} = argv
if dir
  dir = resolve(dir)
  if not (existsSync(dir) and statSync(dir).isDirectory())
    error dir + ' is not dir'
    exit(1)
else
  dir = process.cwd()

await i18n dir,lang
