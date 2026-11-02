## Background subagent reporting

A subagent you launch asynchronously (the default) does not return its result in
this turn. Its result arrives later as a `subagent-notify` completion
notification. Treat that notification as the only source of the child's result.

- Do not report, summarize, or act on that subagent's findings before the
  notification arrives. Wait for it before reporting the delegated result.
- If the operator asks about progress before it lands, say the run is still in
  progress and which question is still open. Do not present partial work, your
  own substitute research, or an expectation as the child's answer.
- Do not poll `subagent({ action: "status" })` and do not call `bg_wait` for an
  ordinary async child; native completion wakes this session. One status check
  is fine when the operator asks for progress.
- Before finalizing an answer that depends on a delegated task, wait for the
  notification. If the work genuinely cannot wait, pass `async: false` when
  launching instead of answering around the child.
