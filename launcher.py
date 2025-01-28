import logging
import re
from subprocess import PIPE, Popen
logger = logging.getLogger(__name__)

REAPER_PATH = '/Applications/REAPER.app/Contents/MacOS/REAPER'


def run_reaper():
    def extract_percentage(text):
        # Define the regular expression pattern to match the percentage
        pattern = r"swt 'Complete: (\d+)%"

        # Search for the pattern in the text
        match = re.search(pattern, text)

        if match:
            # Extract the percentage value
            percentage = match.group(1)
            return int(percentage)
        else:
            return None

    logger.info('STARTING REAPER')
    reaper_project = "project.RPP"
    lua_script = "script.lua"

    command = f"stdbuf -oL -eL /bin/bash -c '{REAPER_PATH} {reaper_project} {lua_script}'"
    process = Popen(command, shell=True, stdout=PIPE,
                    stderr=PIPE, bufsize=1, universal_newlines=True)

    # Log the output in real-time
    for line in process.stdout:
        status = line.strip()
        percentage = extract_percentage(status)
        if percentage is not None:
            print(percentage)
        logger.info(status)

    for line in process.stderr:
        logger.error(line.strip())

    process.stdout.close()
    process.stderr.close()
    return_code = process.wait()
    if return_code == 0:
        logger.info('REAPER command executed successfully.')
    else:
        logger.error("REAPER command failed with return code: %s", return_code, exc_info=True)


if __name__ == '__main__':
    run_reaper()
