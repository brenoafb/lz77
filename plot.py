import matplotlib.pyplot as plt
import numpy as np
import sys

def read_input(filename):
    with open(filename) as f:
        lines = f.readlines()
        data = []
        for line in lines:
            x = int(line, 16)
            data.append(x)
    return np.array(data)

def plot_histogram(data, title=None, filename=None):
    plt.hist(data, bins='auto')
    if title:
        plt.title(title)
    if filename:
        plt.savefig(filename)
    else:
        plt.show()


if __name__ == "__main__":
    title = None
    figure_filename = None
    if len(sys.argv) == 2:
        [_, filename] = sys.argv
    elif len(sys.argv) == 3:
        [_, filename, title] = sys.argv
    elif len(sys.argv) == 4:
        [_, filename, title, figure_filename] = sys.argv
    else:
        print("Please supply at least the input filename")
        exit()
    data = read_input(filename)
    plot_histogram(data, title=title, filename=figure_filename)
