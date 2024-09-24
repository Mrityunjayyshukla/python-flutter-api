from flask import Flask, request, jsonify
import json, os

app = Flask(__name__)


data_file = 'data_record.json'

if not os.path.exists(data_file):
    with open(data_file, 'w') as f:
        json.dump([],f)

# GET
@app.route('/api', methods=['GET'])
def returnascii():
    inputchr = str(request.args['query'])
    d = {
        'output1': inputchr,
        'output2': inputchr[::-1]
    }
    return jsonify(d)

# POST
@app.route('/api/post', methods=["POST"])
def handle_post():
    try: 
        data = request.json
        print(data)
        inputchr = data.get('query', '')

        with open(data_file, 'r+') as f:
            file_data = json.load(f) # Load existing data
            file_data.append({'query': inputchr}) # Append new Entry
            f.seek(0) # Move cursor to beginning of file
            json.dump(file_data, f, indent=4) # Write updated data
            f.truncate()

        response_data = {
            'output1': inputchr,
            'output2': inputchr[::-1],
        }
        return jsonify(response_data)
    
    except Exception as e:
        print(f"Error occured: {e}")
        return jsonify({"error": str(e)}), 500

# PUT
@app.route('/api/put', methods=["PUT"])
def handle_put():
    try:
        data = request.json
        inputchr = data.get('query', '')
        
        with open(data_file, 'r+') as f:
            file_data = json.load(f)  # Load existing data
            # Example: Update the last entry, or implement your own logic
            if file_data:
                file_data[-1]['query'] = inputchr  # Update last entry as an example
            f.seek(0)  # Move cursor to beginning of file
            json.dump(file_data, f, indent=4)  # Write updated data
            f.truncate()

        response_data = {
            'output1': inputchr,
            'output2': inputchr[::-1],
        }
        return jsonify(response_data)
    
    except Exception as e:
        print(f"Error occurred: {e}")
        return jsonify({"error": str(e)}), 500

# Delete 
@app.route('/api/delete', methods=["DELETE"])
def handle_delete():
    try:
        data = request.json
        inputchr = data.get('query', '')

        with open(data_file, 'r+') as f:
            file_data = json.load(f)  # Load existing data
            
            # Find and remove the entry that matches the input
            file_data = [entry for entry in file_data if entry['query'] != inputchr]
            
            f.seek(0)  # Move cursor to beginning of file
            json.dump(file_data, f, indent=4)  # Write updated data
            f.truncate()

        response_data = {
            'output1': inputchr,
            'output2': "Entry deleted",
        }
        return jsonify(response_data)

    except Exception as e:
        print(f"Error occurred: {e}")
        return jsonify({"error": str(e)}), 500


if __name__=="__main__":
    app.run()