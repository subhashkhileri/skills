---
name: quiz-me
description: Quiz the user on a topic to test their real understanding — not just what was discussed, but the broader knowledge needed to truly grasp it. Uses multiple-choice questions via AskUserQuestion, grades answers, explains mistakes, and continues in rounds. Use when the user says "quiz me", "test me", "check my understanding", or wants to verify they understood what was discussed.
---

Quiz the user to verify they truly understand a topic — not just what was said in conversation, but the underlying concepts needed to apply that knowledge confidently.

## How it works

1. Identify the topic from the conversation or from what the user specifies
2. Build a mental map of the topic that includes:
   - What was explicitly discussed in the conversation
   - Foundational concepts the user would need to know for the discussion to make sense (prerequisites)
   - Related concepts that weren't discussed but are important for real-world understanding (adjacent knowledge)
   - Common misconceptions people have about this topic
3. Generate 3-4 multiple-choice questions per round using AskUserQuestion, sent as a single batch
4. After each round, score the results and explain any wrong answers clearly — restate the concept so the user actually learns, don't just say "wrong"
5. Automatically continue to the next round — run at least 5 rounds before asking if they want to stop. After round 5, ask if they want to continue

## Question mix

Each round should blend three types of questions:

- **From the conversation** (~1-2 questions): Test understanding of what was actually discussed. Don't test recall ("what did I say about X?") — test comprehension ("why does X work this way?")
- **Foundational** (~1 question): Test the prerequisite knowledge that the conversation assumed. If the conversation was about NetworkPolicies, this might ask about how Kubernetes networking works in general, what a CNI plugin does, or how pod IPs are assigned — things the user needs to know for the discussed topic to make sense
- **Adjacent** (~1 question): Test related knowledge that wasn't covered but a person who truly understands the topic should know. If the conversation was about NetworkPolicies, this might ask about how they interact with Services, what happens during pod restarts, or how they differ from security groups in cloud providers

This mix ensures the quiz tests real understanding, not just "were you paying attention."

## Question design

- **CRITICAL — Randomize correct answer position**: The correct answer MUST NOT always be the first option. For each question, randomly place the correct answer in position 1, 2, 3, or 4. Across a round of 3-4 questions, the correct answer should appear in different positions. If a user can score 100% by always picking the first option, the quiz is broken.
- Questions should test understanding, not memorization — "why does X work this way?" is better than "what is the name of X?"
- Wrong options should be plausible, not obviously absurd — they should represent real misconceptions someone learning this topic would have
- Cover different aspects: definitions, cause-and-effect, comparisons, edge cases, and "what happens if..." scenarios
- Do NOT revisit wrong answers in the immediately following round — keep moving forward with new concepts. Track what the user got wrong and offer a focused revisit round at the end of the quiz (after round 5+) if they want it
- When asking about something not discussed in conversation, briefly provide context in the question itself so the user has a fair chance — the goal is testing understanding, not ambushing them with topics they've never seen

## Tone

Keep it encouraging. The point is learning, not gotchas. When the user gets something wrong, explain it like you're helping a colleague — not marking an exam. When explaining, avoid jargon or define it inline.

## Adapting to the user

- If the user specifies a topic ("quiz me on NetworkPolicies"), focus on that
- If no topic is specified, cover the full breadth of the conversation
- If the user is getting everything right, make the next round harder — go deeper into edge cases, adjacent concepts, and real-world scenarios
- If the user is struggling, pull back to fundamentals before moving on
- Track which questions the user got wrong across all rounds. After the final round, offer: "Want to continue with new topics, revisit the concepts you missed, or stop?"

## Important

- Always use AskUserQuestion with multiple-choice options — don't ask open-ended questions in plain text
- Send 3-4 questions per round in a single AskUserQuestion call so the user can answer them as a batch
- Run a minimum of 5 rounds automatically — after grading each round, immediately proceed to the next without asking. Only after round 5 (or later), ask if the user wants to continue
