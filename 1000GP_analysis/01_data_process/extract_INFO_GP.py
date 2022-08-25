import vcf
import pandas as pd
import sys, getopt

vcf_f=""
location=""
output=""
options, remainder = getopt.gnu_getopt(sys.argv[1:], 'VLO',['vcf=','location=','output='])
for opt,arg in options:
	if opt in ('--vcf'):
		vcf_f=arg	
	elif opt in ('--location'):
		location=arg
	elif opt in ('--output'):
		output=arg

chromosome_read = location.split(':')[0]
start_read = location.split(':')[1].split('-')[0]
end_read = location.split(':')[1].split('-')[1]

vcf_reader = vcf.Reader(filename=vcf_f).fetch(str(chromosome_read), int(start_read), int(end_read))
variant_list_df = []
for i in vcf_reader:
		AF=str(i.INFO["AF"][0])
		EAS_AF = str(i.INFO["EAS_AF"][0])
		EUR_AF = str(i.INFO["EUR_AF"][0])
		AFR_AF = str(i.INFO["AFR_AF"][0])
		AMR_AF = str(i.INFO["AMR_AF"][0])
		SAS_AF = str(i.INFO["SAS_AF"][0])

		item = {"AF":AF,"EAS_AF":EAS_AF,"EUR_AF":EUR_AF,"AFR_AF":AFR_AF,"AMR_AF":AMR_AF,"SAS_AF":SAS_AF}

		variant_list_df.append(item)
		
variant_list_df = pd.DataFrame(variant_list_df)
output_file = output+'.txt'
variant_list_df.to_csv(output_file, index = False, header=True, sep='\t')
