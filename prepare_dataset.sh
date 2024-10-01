#!/bin/bash

MODEL_ID="THUDM/CogVideoX-2b"

# For more details on the expected data format, please refer to the README.
DATA_ROOT="/raid/aryan/video-dataset-tom-and-jerry"  # This needs to be the path to the base directory where your videos are located.
CAPTION_COLUMN="prompts.txt"
VIDEO_COLUMN="videos.txt"
OUTPUT_DIR="/raid/aryan/video-dataset-tom-and-jerry-encoded"
HEIGHT=480
WIDTH=720
MAX_NUM_FRAMES=49
MAX_SEQUENCE_LENGTH=226
TARGET_FPS=8
BATCH_SIZE=1
DTYPE=fp32

# To create a folder-style dataset structure without pre-encoding videos and captions'
CMD_WITHOUT_PRE_ENCODING="\
  python3 training/prepare_dataset.py \
    --model_id $MODEL_ID \
    --data_root $DATA_ROOT \
    --caption_column $CAPTION_COLUMN \
    --video_column $VIDEO_COLUMN \
    --output_dir $OUTPUT_DIR \
    --height $HEIGHT \
    --width $WIDTH \
    --max_num_frames $MAX_NUM_FRAMES \
    --max_sequence_length $MAX_SEQUENCE_LENGTH \
    --target_fps $TARGET_FPS \
    --batch_size $BATCH_SIZE \
    --dtype $DTYPE
"

CMD_WITH_PRE_ENCODING="$CMD_WITHOUT_PRE_ENCODING --save_tensors"

# Select which you'd like to run
CMD=$CMD_WITH_PRE_ENCODING

echo "===== Running \`$CMD\` ====="
eval $CMD
echo -ne "===== Finished running script =====\n"