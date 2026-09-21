// record.mjs — stage the example session. Plain English: this is a puppet show of a user test. It
// opens the fictional interface (index.html), moves a drawn cursor and clicks through a scripted
// timeline while Playwright records the screen, then converts the video to recording.mp4. The
// transcript in ../sessions/2026-09-21-1000-priya-nair/transcript.txt was written to match this
// timeline with a deliberate 15-second offset (transcript time = recording time + 15), so the kit's
// offset step has something real to measure. No real product, participant or client is involved.
// Needs: node 18+, ffmpeg on PATH, and playwright — either `npm i playwright && npx playwright
// install chromium` in this folder, or PLAYWRIGHT_FROM=/path/to/a/project/that/has/it.
// Usage: node record.mjs
import { fileURLToPath } from 'node:url'
import { dirname, join } from 'node:path'
import { execFileSync } from 'node:child_process'
import { mkdirSync, rmSync } from 'node:fs'

const here = dirname(fileURLToPath(import.meta.url))
const SESSION = join(here, '..', 'sessions', '2026-09-21-1000-priya-nair')
const TMP = join(here, '.video')

async function loadPlaywright() {
  try { return await import('playwright') } catch {}
  const from = process.env.PLAYWRIGHT_FROM
  if (!from) throw new Error('playwright not found. Run `npm i playwright && npx playwright install chromium` in example/interface, or set PLAYWRIGHT_FROM=/path/to/a/project/that/has/it')
  const { createRequire } = await import('node:module')
  return createRequire(join(from, 'package.json'))('playwright')
}

const { chromium } = await loadPlaywright()
rmSync(TMP, { recursive: true, force: true }); mkdirSync(TMP, { recursive: true })
const browser = await chromium.launch()
const context = await browser.newContext({ viewport: { width: 1280, height: 800 }, recordVideo: { dir: TMP, size: { width: 1280, height: 800 } } })
const page = await context.newPage()
const video = page.video()
const t0 = Date.now()
const at = async (sec) => { const wait = t0 + sec * 1000 - Date.now(); if (wait > 0) await page.waitForTimeout(wait) }
const cursorTo = async (sel, dx = 0.5, dy = 0.5) => {
  const r = await page.evaluate(s => window.demo.rect(s), sel)
  if (r) await page.evaluate(([x, y]) => window.demo.cursor(x, y), [r.x + r.w * dx, r.y + r.h * dy])
}
const cursorXY = (x, y) => page.evaluate(([x, y]) => window.demo.cursor(x, y), [x, y])
const click = (sel) => page.evaluate(s => window.demo.click(s), sel)
const focus = (sel) => page.evaluate(s => window.demo.focus(s), sel)

await page.goto('file://' + join(here, 'index.html'))
// Timeline in RECORDING seconds. Transcript time = recording time + 15.
await at(2);   await cursorTo('#nav-clients')            // 0:17  "clients?"
await at(5);   await cursorTo('#nav-backlog')            // 0:20  "...or is it this Backlog thing?"
await at(8);   await cursorXY(300, 420)
await at(11);  await cursorTo('#nav-backlog', 0.6, 0.5)  // hovers, unsure
await at(18);  await click('#nav-backlog')               // 0:33  "I'll try Backlog"
await at(19);  await cursorTo('#card-wf', 0.2, 0.5)
await at(21);  await cursorTo('#chip-fraction')          // 0:36  "two of four?"
await at(25);  await cursorTo('#chip-fraction', 0.9, 0.9)
await at(28);  await cursorTo('#chip-fraction', 0.1, 0.2)
await at(33);  await cursorTo('#card-wf', 0.15, 0.4)
await at(40);  await click('#card-wf')                   // 0:55  "I'll open it"
await at(41);  await cursorXY(420, 260)
await at(44);  await cursorXY(420, 300)                  // reads the checklist
await at(47);  await cursorTo('#chip-ack-detail')        // 1:02  "1 to acknowledge?"
await at(52);  await cursorTo('#chip-ack-detail', 0.8, 0.5)
await at(55);  await cursorTo('#start')                  // 1:10  "I'd start the job"
await at(57);  await click('#start')                     // 1:12  click — nothing visible happens
await at(58);  await cursorTo('#start', 0.6, 0.6)
await at(61);  await cursorXY(700, 560)                  // 1:16  the button has just greyed
await at(64);  await cursorTo('#start', 0.5, 0.5)
await at(70);  await cursorXY(760, 400)
await at(80);  await cursorXY(760, 420)                  // 1:35–1:50  talking about the notebook
await at(96);  await cursorTo('#target')                 // 1:51  "target date, first of September"
await at(100); await focus('#target')
await at(103); await cursorTo('#deadline')               // 1:58  "this one underneath has no label"
await at(112)
await context.close(); await browser.close()
const webm = await video.path()
mkdirSync(SESSION, { recursive: true })
execFileSync('ffmpeg', ['-y', '-loglevel', 'error', '-i', webm, '-c:v', 'libx264', '-pix_fmt', 'yuv420p', '-crf', '24', '-r', '25', '-an', join(SESSION, 'recording.mp4')])
rmSync(TMP, { recursive: true, force: true })
console.log('wrote', join(SESSION, 'recording.mp4'))
