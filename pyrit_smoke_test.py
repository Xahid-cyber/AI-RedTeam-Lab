import asyncio

from pyrit.converter import JsonStringConverter
from pyrit.executor.attack import AttackConverterConfig, PromptSendingAttack
from pyrit.output import output_attack_async
from pyrit.prompt_normalizer import ConverterConfiguration
from pyrit.prompt_target import (
    HTTPTarget,
    get_http_target_json_response_callback_function,
)
from pyrit.setup import IN_MEMORY, initialize_pyrit_async


async def main():
    # Keep PyRIT memory temporary for this first connectivity test.
    await initialize_pyrit_async(memory_db_type=IN_MEMORY)

    # This is the exact HTTP request PyRIT will use to call our FastAPI chatbot.
    raw_http_request = """
POST http://127.0.0.1:8000/chat HTTP/1.1
Host: 127.0.0.1:8000
Content-Type: application/json

{"message":"{PROMPT}"}
"""

    # Our FastAPI endpoint returns JSON like:
    # {"response": "..."}
    parse_response = get_http_target_json_response_callback_function(
        key="response"
    )

    target = HTTPTarget(
        http_request=raw_http_request,
        prompt_regex_string="{PROMPT}",
        callback_function=parse_response,
        use_tls=False,
        timeout=60.0,
        model_name="Northwind Retail Chatbot",
    )

    # Makes arbitrary prompts safe to insert into a JSON string.
    converter_config = AttackConverterConfig(
        request_converters=ConverterConfiguration.from_converters(
            converters=[JsonStringConverter()]
        )
    )

    attack = PromptSendingAttack(
        objective_target=target,
        attack_converter_config=converter_config,
    )

    # First PyRIT smoke test: normal in-scope request.
    result = await attack.execute_async(
        objective="Where is my order?"
    )

    await output_attack_async(result)


if __name__ == "__main__":
    asyncio.run(main())
