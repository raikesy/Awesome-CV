.PHONY: examples

CC = xelatex
SRC_DIR = src
RESUME_DIR = $(SRC_DIR)/resume
CV_DIR = $(SRC_DIR)/cv
OUTPUT_DIR = out
RESUME_SRCS = $(shell find $(RESUME_DIR) -name '*.tex')
CV_SRCS = $(shell find $(CV_DIR) -name '*.tex')

examples: $(foreach x, coverletter cv resume, $x.pdf)

resume.pdf: $(EXAMPLES_DIR)/resume.tex $(RESUME_SRCS)
	$(CC) -output-directory=$(OUTPUT_DIR) $<

cv.pdf: $(EXAMPLES_DIR)/cv.tex $(CV_SRCS)
	$(CC) -output-directory=$(OUTPUT_DIR) $<

coverletter.pdf: $(EXAMPLES_DIR)/coverletter.tex
	$(CC) -output-directory=$(OUTPUT_DIR) $<

clean:
	rm -rf $(EXAMPLES_DIR)/*.pdf
