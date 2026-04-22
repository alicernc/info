# CBorg

[CBorg](https://cborg.lbl.gov/) provides access to LLMs through [a chat interface](https://chat.cborg.lbl.gov/), as well as through API calls.
As of 2026 April, each user is provided with $50/month in usage, per [here](https://cborg.lbl.gov/api_cborgvscloud/).
I (RJE) encourage you to look through the CBorg website - they have all kinds of info and tutorials, such as
[recommendations for models and tools to use](https://cborg.lbl.gov/tools_ai_101/).

# Claude Code with CBorg

1. Install Claude Code
2. [Get a CBorg API key](https://cborg.lbl.gov/api_request/)
3. [Setup via the CBorg docs on using Claude Code](https://cborg.lbl.gov/tools_claudecode/).

> [!INFO]
> Instead of having to define those env variables in your current environment (which can be annoying to maintain), you can add them to you Claude Code settings stored at `~/.claude/settings.json`.


An example `settings.json` is below (based on the defaults provided by the CBorg page from a few months ago.
It looks like they've changed a bit, so you should double check):

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "YOUR_API_KEY",
    "ANTHROPIC_BASE_URL": "https://api.cborg.lbl.gov",
    "ANTHROPIC_DEFAULT_HAIKU_MODEL": "claude-haiku",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "claude-sonnet",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "claude-opus",
    "ANTHROPIC_MODEL": "claude-sonnet",
    "CLAUDE_CODE_SUBAGENT_MODEL": "claude-haiku",
    "DISABLE_NON_ESSENTIAL_MODEL_CALLS": "1",
    "DISABLE_TELEMETRY": "1",
    "CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS": "1",
    "CLAUDE_CODE_MAX_OUTPUT_TOKENS": "8192"
  }
}
```


> [!WARNING]
> Claude code can burn through tokens quickly. You can check your API budget [here](https://api.cborg.lbl.gov/key/manage)

I'm not sure what happens if you run out of budget - I've never pushed it that far. There is some [info in the FAQ](https://cborg.lbl.gov/api_faq/).
