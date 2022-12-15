# gets enumerates files from a directory and returns and random
import os
import random


def get_random_meme():
    path = "./static/images"
    files = os.listdir(path)
    file_list = []

    for file in files:
        name = f'/images/{file}'
        file_list.append(name)

    selected_image = random.choice(file_list)

    return selected_image
