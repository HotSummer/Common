import sys
import json
import os
import getopt
def processRequestSchema_h(schemaName):
	if schemaName in processedReqH:
		return;

	file_name = ('./%s/%s.request' %(request_schema_dir,schemaName))
	file_obj = open(file_name);
	json_obj = json.loads(file_obj.read())

	baseClass = 'VSDAutoMappingRequestDto'
	if json_obj['request'].get('extends') != None:
		baseClass = ('%s%s%s' %(app_prefix,json_obj['request'].get('extends'),'RequestDto')) 
		processRequestSchema_h(json_obj['request'].get('extends'))


	req_h_file_obj.write(('@interface %s%s%s : %s\n' %(app_prefix,schemaName,'RequestDto',baseClass)));
	for define in  json_obj["request"]["def"]:
		paramName = define["name"]
		paramType = define["type"]
		if paramType == 'integer':
			req_h_file_obj.write(('@property (nonatomic,retain) NSNumber *%s;\n' %(paramName)))
		elif paramType == 'string':
			req_h_file_obj.write(('@property (nonatomic,retain) NSString *%s;\n' %(paramName)))

	req_h_file_obj.write('@end\n\n');
	processedReqH.append(schemaName)
	file_obj.close()
	return

def processRequestSchema_m(schemaName):
	file_name = ('./%s/%s.request' %(request_schema_dir,schemaName))
	file_obj = open(file_name);
	json_obj = json.loads(file_obj.read())

	req_m_file_obj.write(('@implementation %s%s%s\n' %(app_prefix,schemaName,'RequestDto')));
	#response = null means it is a base dto, doesn't need parser or model
	if json_obj["request"].get('url') != None:
		req_m_file_obj.write('-(void)buildRequestURL\n')
		req_m_file_obj.write('{\n')
		req_m_file_obj.write(('	self.URLString = [NSString stringWithFormat:@\"%%@%%@\", API_ROOT,@\"%s\"];\n' %(json_obj["request"]["url"])))
		req_m_file_obj.write('}\n')

		req_m_file_obj.write('-(Class)parserClass\n')
		req_m_file_obj.write('{\n')
		req_m_file_obj.write(('	return [%s%sRequestParser class];\n' %(app_prefix,schemaName)))
		req_m_file_obj.write('}\n')
		

	req_m_file_obj.write('@end\n\n');

	file_obj.close()
	return


def processRequestParserSchema_h(schemaName,json_obj,dst_file_obj):
	if json_obj["request"].get('url') == None:
		return

	dst_file_obj.write(('@interface %s%s%s : VSDAutoMappingParser\n' %(app_prefix,schemaName,'RequestParser')));
	dst_file_obj.write('@end\n\n');
	return

def processRequestParserSchema_m(schemaName,json_obj,dst_file_obj):
	if json_obj["request"].get('url') == None:
		return

	define = json_obj["response"]["def"][0];
	respType = define["type"]
	respTypeClass = define["typeClass"]
	className = ('%s%s' %(app_prefix,respTypeClass))
	
	parser_m_buffer.append(('@implementation %s%s%s \n' %(app_prefix,schemaName,'RequestParser')));
	parser_m_buffer.append('- (Class)modelClass\n');
	parser_m_buffer.append('{\n');
	parser_m_buffer.append(('	return [%s%sResponse class];\n' %(app_prefix,schemaName)))
	parser_m_buffer.append('}\n');
	parser_m_buffer.append('@end\n\n');
	return




def  processSchema():
	for schemaName in schemaNames:
		processRequestSchema(schemaName)
		processRequestParser(schemaName)
		processResponse(schemaName)
	return 

def processRequestSchema(schemaName):

	processRequestSchema_h(schemaName)
	processRequestSchema_m(schemaName)
	
	return 

def processRequestParser(schemaName):
	file_name = ('./%s/%s.request' %(request_schema_dir,schemaName))
	file_obj = open(file_name);
	json_obj = json.loads(file_obj.read())
	processRequestParserSchema_h(schemaName,json_obj,parser_h_file_obj)
	processRequestParserSchema_m(schemaName,json_obj,parser_m_file_obj)
	file_obj.close()
	

def processResponse(schemaName):
	
	processResponseSchema_h(schemaName)
	processResponseSchema_m(schemaName)
	return 

def processResponseSchema_h(schemaName):
	if schemaName in processedRespH:
		return;
	file_name = ('./%s/%s.request' %(request_schema_dir,schemaName))
	file_obj = open(file_name);
	json_obj = json.loads(file_obj.read())
	baseClass = 'VSDResponse'
	if json_obj['response'].get('extends') != None:
		baseClass = ('%s%s%s' %(app_prefix,json_obj['response'].get('extends'),'Response')) 
		processResponseSchema_h(json_obj['response'].get('extends'))

	response_h_buffer.append(('@interface %s%sResponse: %s\n\n' %(app_prefix,schemaName,baseClass)))
	defines = json_obj['response']['def']
	for define in defines:
		propName = define['name']
		propType = define['type']
			

		realType = 'NSString'
		if propType == 'integer' or propType == 'long':
			realType = 'NSNumber'
		elif propType == 'array':
			realType = 'NSMutableArray'
			response_h_buffer.append(('- (Class) typeOf%s; \n' %(propName)))

		elif propType == 'obj':
			propClass = define['typeClass']
			realType = '%s%s' %(app_prefix,propClass)

		response_h_buffer.append(('@property (nonatomic,retain) %s *%s;\n' %(realType,propName)))
		
	response_h_buffer.append('\n@end\n\n')

	file_obj.close()
	processedRespH.append(schemaName)

	return

def processResponseSchema_m(schemaName):	
	file_name = ('./%s/%s.request' %(request_schema_dir,schemaName))
	file_obj = open(file_name);
	json_obj = json.loads(file_obj.read())
	response_m_buffer.append(('@implementation %s%sResponse\n\n' %(app_prefix,schemaName)))
	defines = json_obj['response']['def']
	for define in defines:
		propName = define['name']
		propType = define['type']
		realType = 'NSString'
		if propType == 'array':
			typeClass = define['typeClass']
			realType = '%s%s' %(app_prefix,typeClass)

			response_m_buffer.append(('- (Class) typeOf%s \n' %(propName)))
			response_m_buffer.append('{\n');
			response_m_buffer.append('	return [%s class];\n' %(realType));
			response_m_buffer.append('}\n');

	response_m_buffer.append('\n@end\n\n')

	file_obj.close()

	return
	

def processModel_h(modelName):
	if modelName in modelNameH:
		return;
	file_name = ('./%s/%s.model' %(request_schema_dir,modelName))
	file_obj = open(file_name);
	json_obj = json.loads(file_obj.read())
	defines = json_obj['def']
	tmpBuf = []
	for define in defines:
		propName = define['name']
		propType = define['type']
		realType = 'NSString'
		if propType == 'integer' or propType == 'long':
			realType = 'NSNumber'
		elif propType == 'array':
			realType = 'NSMutableArray'
			tmpBuf.append(('- (Class) typeOf%s; \n' %(propName)))
		elif propType == 'obj':
			typeClass = define['typeClass']
			realType = '%s%s' %(app_prefix,typeClass)

			processModel_h(typeClass)

		tmpBuf.append(('@property (nonatomic,retain) %s *%s;\n' %(realType,propName)))
	model_h_buffer.append(('@interface %s%s: NSObject\n\n' %(app_prefix,modelName)))
	model_h_buffer.extend(tmpBuf)
	model_h_buffer.append('\n@end\n\n')
	modelNameH.append(modelName);
	file_obj.close();
	return

def processModel_m(modelName):
	
	model_m_buffer.append(('@implementation %s%s\n\n' %(app_prefix,modelName)))
	file_name = ('./%s/%s.model' %(request_schema_dir,modelName))
	file_obj = open(file_name);
	json_obj = json.loads(file_obj.read())
	defines = json_obj['def']
	for define in defines:
		propName = define['name']
		propType = define['type']
		realType = 'NSString'
		if propType == 'array':
			typeClass = define['typeClass']
			realType = '%s%s' %(app_prefix,typeClass)

			model_m_buffer.append(('- (Class) typeOf%s \n' %(propName)))
			model_m_buffer.append('{\n');
			model_m_buffer.append('	return [%s class];\n' %(realType));
			model_m_buffer.append('}\n');

	model_m_buffer.append('\n@end\n\n')
	return

def processModel():
	for modelName in modelNames:
		processModel_h(modelName)
		processModel_m(modelName)

	return

opts, args = getopt.getopt(sys.argv[1:], "hs:o:p:")

app_prefix = ''
request_schema_dir = '.'
dist_dir = '.'
for op, value in opts:
	if op == "-s":
		request_schema_dir = value
	elif op == "-o":
		dist_dir = value
	elif op == "-p":
		app_prefix = value

parser_m_buffer = []
model_h_buffer = []
model_m_buffer = []
response_h_buffer = []
response_m_buffer = []
schemaNames = []
modelNames = []
processedReqH = []
processedRespH = []
modelNameH = []

dirs = os.listdir(request_schema_dir)
for d in dirs:
	if d.endswith('.request'):
		schemaNames.append(d.replace('.request',''))
	elif d.endswith('.model'):
		modelNames.append(d.replace('.model',''))

req_h_file_name = ('%s/%s%s' %(dist_dir,app_prefix,'GlobalRequestDto.h'))
req_h_file_obj = open (req_h_file_name,'w')

req_h_file_obj.write('#import <VSDNetworking/VSDAutoMappingRequestDto.h>\n')
req_h_file_obj.write('#import <VSDNetworking/VSDAPIRepository.h>\n')
req_h_file_obj.write(('#import \"%s%s.h\"\n' %(app_prefix,'GlobalRequestParser')))

req_m_file_name = ('%s/%s%s' %(dist_dir,app_prefix,'GlobalRequestDto.m'))
req_m_file_obj = open (req_m_file_name,'w')
req_m_file_obj.write(('#import \"%s%s.h\"\n' %(app_prefix,'GlobalRequestDto')))
req_m_file_obj.write('#define API_ROOT @\"http://url\"\n')


parser_h_file_name = ('%s/%s%s' %(dist_dir,app_prefix,'GlobalRequestParser.h'))
parser_h_file_obj = open (parser_h_file_name,'w')
parser_h_file_obj.write('#import <VSDNetworking/VSDAutoMappingParser.h>\n')

parser_m_file_name = ('%s/%s%s' %(dist_dir,app_prefix,'GlobalRequestParser.m'))
parser_m_file_obj = open (parser_m_file_name,'w')
parser_m_file_obj.write(('#import \"%s%s.h\"\n' %(app_prefix,'GlobalRequestParser')))
parser_m_file_obj.write(('#import \"%s%s.h\"\n' %(app_prefix,'GlobalResponse')))


response_h_file = ('%s/%s%s' %(dist_dir,app_prefix,'GlobalResponse.h'))
response_h_obj = open(response_h_file, 'w')
response_h_buffer.append('#import <VSDNetworking/VSDResponse.h>\n')
response_h_buffer.append('#import \"%sGlobalModel.h\"\n' %(app_prefix));

response_m_file = ('%s/%s%s' %(dist_dir,app_prefix,'GlobalResponse.m'))
response_m_obj = open(response_m_file, 'w')
response_m_buffer.append('#import \"%sGlobalResponse.h\"\n' %(app_prefix));
response_m_buffer.append('#import \"%sGlobalModel.h\"\n' %(app_prefix));
processSchema()


for buf in response_h_buffer:
	response_h_obj.write(buf)

for buf in response_m_buffer:
	response_m_obj.write(buf)

for buf in parser_m_buffer:
	parser_m_file_obj.write(buf)

response_m_obj.close()
req_h_file_obj.close()
req_m_file_obj.close()
parser_h_file_obj.close();
parser_m_file_obj.close()
response_h_obj.close()


model_h_file = ('%s/%s%s' %(dist_dir,app_prefix,'GlobalModel.h'))
model_h_obj = open(model_h_file, 'w')
model_m_file = ('%s/%s%s' %(dist_dir,app_prefix,'GlobalModel.m'))
model_m_obj = open(model_m_file, 'w')
model_m_buffer.append('#import \"%sGlobalModel.h\"\n' %(app_prefix));

processModel()

for buf in model_h_buffer:
	model_h_obj.write(buf)

for buf in model_m_buffer:
	model_m_obj.write(buf)

model_m_obj.close()
model_h_obj.close()