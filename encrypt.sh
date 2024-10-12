#!/bin/bash

# Variables
BUCKET_NAME="criticalproductionbucket"
OLD_EXTENSION="txt"
NEW_EXTENSION="txt"  # Change to the desired new extension
ENCRYPTION_KEY="somecomplicatedkey"  # Replace with your symmetric key or generate one
ENCRYPTION_ALGO="aes-256-cbc"  # You can use a different algorithm if desired

# List all objects with the .txt extension in the bucket
OBJECTS=$(aws s3api list-objects --bucket "$BUCKET_NAME" --query "Contents[?ends_with(Key, '.${OLD_EXTENSION}')].Key" --output text)

# Check if there are any objects to process
if [ -z "$OBJECTS" ]; then
    echo "No objects found with the .${OLD_EXTENSION} extension in the bucket."
    exit 1
fi

# Loop through each object, encrypt it, and re-upload
for FILE in $OBJECTS; do
    # Extract the file name and remove the old extension
    FILE_NAME=$(basename "$FILE")

    # Create the new file name with the new extension
    NEW_FILE_NAME="${FILE_NAME%.*}.$NEW_EXTENSION"
    ENCRYPTED_FILE="${NEW_FILE_NAME}.enc"

    # Download the object from S3
    aws s3 cp "s3://$BUCKET_NAME/$FILE" "$FILE_NAME"

    # Encrypt the file using OpenSSL
    openssl enc -${ENCRYPTION_ALGO} -salt -in "$FILE_NAME" -out "$ENCRYPTED_FILE" -pass pass:"$ENCRYPTION_KEY"

    # Upload the encrypted file back to S3 with the new extension
    aws s3 cp "$ENCRYPTED_FILE" "s3://$BUCKET_NAME/$NEW_FILE_NAME"

    # Optionally, delete the old file from S3
    # Uncomment the line below if you want to delete the original file after processing
    # aws s3 rm "s3://$BUCKET_NAME/$FILE"

    # Clean up the local files
    rm "$FILE_NAME" "$ENCRYPTED_FILE"

    echo "File $FILE has been encrypted and uploaded to S3 as $NEW_FILE_NAME."
done

echo "All .${OLD_EXTENSION} files have been encrypted and processed."
