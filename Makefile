# Input
PREFIX ?= img_
SUFFIX ?= jpg
N ?= 50
INFORMAT ?= %03d

# Output
NAME ?= timelapse
IMAGE_SUFFIX ?= png
VIDEO_SUFFIX ?= mp4
FPS ?= 25

# Sanitize
HOTPIXELS = ~/Pictures/hot-pixels.png

# Filtering
OFFSET ?= 0
LIMIT ?= 999999

# Processing
THREADS ?= 4
PART ?= part
VF ?= scale=1920:1280,crop=1920:1080:0:100

# Values
OP_LIGHTEN ?= -evaluate-sequence Max
#OP_LIGHTEN ?= -compose Lighten

plus = $(shell echo $(1)+$(2) | bc)
minus = $(shell echo $(1)-$(2) | bc)
index = $(shell echo $(1) | gsed 's_$(PART)\([0-9]\+\).$(IMAGE_SUFFIX)_\1_g')
images = $(wordlist $(call plus,$(OFFSET),1),$(call plus,$(OFFSET),$(LIMIT)),$(wildcard $(PREFIX)*.$(SUFFIX)))
nimages = $(words $(call images))
fimages = $(wordlist $(1),$(call plus,$(1),$(call minus,$(N),1)),$(call images))
parts = $(shell seq $(call plus,$(OFFSET),1) $(N) $(call plus,$(call nimages),$(OFFSET)))

$(PART)%.$(IMAGE_SUFFIX):
	convert $(call fimages,$(call minus,$(call index,$@),$(OFFSET))) $(OP_LIGHTEN) $@

%.$(IMAGE_SUFFIX): $(addprefix $(PART),$(addsuffix .$(IMAGE_SUFFIX),$(call parts)))
	convert $^ $(OP_LIGHTEN) $@

%.$(VIDEO_SUFFIX):
	ffmpeg -threads $(THREADS) -r $(FPS) -i $(PREFIX)$(INFORMAT).$(SUFFIX) -vf $(VF) $@

%_clean.$(SUFFIX): %.$(SUFFIX)
	convert $(HOTPIXELS) $^ -evaluate-sequence Subtract $@

all: image video

image: $(NAME).$(IMAGE_SUFFIX)

video: $(NAME).$(VIDEO_SUFFIX)

clean:
	rm -f $(PART).*

help:
	@cat README.md
