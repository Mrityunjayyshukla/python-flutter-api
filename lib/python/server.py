from flask import Flask, request, jsonify
import json, os

# The server connects with the running Flask application 
# in the launcher.py file
app = Flask(__name__)

# data file is created to store the data in the json format
data_file = 'data_record.json'

# If the data file does not exist, then this piece of code 
# creates a new file named data_file.json in run it in 
# writing format to write the data
if not os.path.exists(data_file):
    with open(data_file, 'w') as f:
        # Add the data
        json.dump([],f)

# GET (Read)
# This decorator tells Flask to map the /api URL path to the 
# returnascii() function, but only for GET requests.
@app.route('/api', methods=['GET'])
def returnascii():
    #The code retrieves a query parameter named query from the URL.
    inputchr = str(request.args['query'])
    # Output dictionary that will be stored in the json format
    d = {
        # Output 1 store the inputchr
        # Output 2 store the inputchr in reverse format
        'output1': inputchr,
        'output2': inputchr[::-1]
    }
    # Translate from dictionary to json format
    return jsonify(d)

# POST (Add the data)
# This line defines a route for the /api/post path, and specifies that it will handle 
# POST requests. When a client sends a POST request to this path, the handle_post() function is invoked.
@app.route('/api/post', methods=["POST"])
def handle_post():
    # Try-Except block for the error handling in any error occurs
    # during POST functioning/
    try: 
        # to parse json data sent in the body of POST 
        data = request.json
        print(data)
        # retrieves the value of the key query from the JSON payload. If 
        # the key doesn't exist, it defaults to an empty string ('').
        inputchr = data.get('query', '')

        # Open the data_file in read-write mode
        with open(data_file, 'r+') as f:
            # Load existing data
            file_data = json.load(f) 
            # Entry is appended to data_file
            file_data.append({'query': inputchr}) 
            # Move cursor to beginning of file
            f.seek(0) 
            # Write updated data
            json.dump(file_data, f, indent=4) 
            f.truncate()

        # response is in format of Dictionary with two outputs
        # Output1 stores inputchr
        # Output2 stores inputchr in reverse order
        response_data = {
            'output1': inputchr,
            'output2': inputchr[::-1],
        }
        # Convert dictionary to json
        return jsonify(response_data)
    
    # If an error occurs, the server logs it and returns a 500 Internal Server Error response with the error message.
    except Exception as e:
        print(f"Error occured: {e}")
        return jsonify({"error": str(e)}), 500

# PUT (Append)
# This line defines a route for the /api/put path, and specifies that it will handle 
# PUT requests. When a client sends a PUT request to this path, the handle_put() function is invoked.
@app.route('/api/put', methods=["PUT"])
def handle_put():
    # Try-Except block for the error handling in any error occurs
    # during PUT functioning/
    try:
        # to parse json data sent in the body of POST 
        data = request.json
        # retrieves the value of the key query from the JSON payload. If 
        # the key doesn't exist, it defaults to an empty string ('').
        inputchr = data.get('query', '')
        
        with open(data_file, 'r+') as f:
            # Load existing data
            file_data = json.load(f)  
            # Update last entry as an example
            if file_data:
                file_data[-1]['query'] = inputchr  
            # Move cursor to beginning of file
            f.seek(0)  
            # Write updated data
            json.dump(file_data, f, indent=4)  
            f.truncate()

        # response is in format of Dictionary with two outputs
        # Output1 stores inputchr
        # Output2 stores inputchr in reverse order
        response_data = {
            'output1': inputchr,
            'output2': inputchr[::-1],
        }
        return jsonify(response_data)
    
    # If an error occurs, the server logs it and returns a 500 Internal Server Error response with the error message.
    except Exception as e:
        print(f"Error occurred: {e}")
        return jsonify({"error": str(e)}), 500

# Delete 
#This defines a Flask route that listens for HTTP DELETE requests at the /api/delete URL. 
# When a DELETE request is sent, the handle_delete() function will be executed.
@app.route('/api/delete', methods=["DELETE"])
def handle_delete():
    # Try-Except block for the error handling in any error occurs
    # during PUT functioning/
    try:
        # Parse json body to incoming request
        data = request.json
        #The get('query', '') retrieves the value associated with the query key from the 
        # JSON data. If the query key is not found, it defaults to an empty string ('').
        inputchr = data.get('query', '')

        # Open data_file in read-write format
        with open(data_file, 'r+') as f:
            # Load existing data
            file_data = json.load(f)  
            
            # Find and remove the entry that matches the input
            file_data = [entry for entry in file_data if entry['query'] != inputchr]
            # Move cursor to beginning of file
            f.seek(0)  
            # Write updated data
            json.dump(file_data, f, indent=4)  
            f.truncate()

        # response is in format of Dictionary with two outputs
        # Output1 stores inputchr
        # Output2 stores the text that says that the entry is deleted
        response_data = {
            'output1': inputchr,
            'output2': "Entry deleted",
        }
        # Convert to json data
        return jsonify(response_data)

    # If an error occurs, the server logs it and returns a 500 Internal Server Error response with the error message.
    except Exception as e:
        print(f"Error occurred: {e}")
        return jsonify({"error": str(e)}), 500

# Run the server file
if __name__=="__main__":
    app.run()