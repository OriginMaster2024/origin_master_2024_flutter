import OpenAI from "https://deno.land/x/openai@v4.24.0/mod.ts";
import * as Sentry from "https://deno.land/x/sentry@8.36.0/index.mjs";

Sentry.init({
  dsn: Deno.env.get("SENTRY_DSN"),
  defaultIntegrations: false,
  tracesSampleRate: 1.0,
  sampleRate: 1.0,
});

// Set region and execution_id as custom tags
Sentry.setTag("region", Deno.env.get("SB_REGION"));
Sentry.setTag("execution_id", Deno.env.get("SB_EXECUTION_ID"));

Deno.serve(async (req) => {
  try {
    const { situation, result, centerPercentages } = await req.json();
    const apiKey = Deno.env.get("OPENAI_API_KEY");
    const openai = new OpenAI({
      apiKey: apiKey,
    });

    const query = `
ホットドッグの持ち方による性格診断をしてください。
以下のシチュエーションにおける結果から、以下の内容を出力してください。

- 性格タイプ: (最も当てはまる性格タイプ)
- 性格タイプの説明: (120文字程度。シチュエーションに言及しつつ（割合は直接言及しない）、性格タイプを説明)

出力は以下の形式としてください。
typeとdescription以外のフィールドは絶対に含めないでください。

{
  "type": "leader" | "freeSpirited" | "seeker" | "revolutionary" | "stabilityOriented",
  "description": "..."
}

# シチュエーション
${situation}

# 結果
ソーセージが${result === "success" ? "落ちなかった" : "落ちた"}。
ソーセージが中心にあった割合は0.2秒ごとに以下の通りだった。
${centerPercentages}

# 性格タイプ
{
  "leader": "リーダー気質",
  "freeSpirited": "自由人",
  "seeker": "探究者",
  "revolutionary": "革命家",
  "stabilityOriented": "安定思考"
}
`;

    const chatCompletion = await openai.chat.completions.create({
      messages: [{ role: "user", content: query }],
      model: "gpt-4o-mini",
      stream: false,
    });

    const reply = chatCompletion.choices[0].message.content;

    return new Response(reply, {
      headers: { "Content-Type": "text/json" },
    });
  } catch (e) {
    Sentry.captureException(e);
    if (e instanceof Error) {
      return new Response(JSON.stringify({ message: e.message }), {
        status: 500,
        headers: { "Content-Type": "application/json" },
      });
    }
    return new Response(JSON.stringify({ message: "unknown error" }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }
});
