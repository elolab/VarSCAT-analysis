import vcf
import pandas as pd

vcf_reader = vcf.Reader(filename="ALL.chrX.shapeit2_integrated_snvindels_v2a_27022019.GRCh38.phased.vcf.gz")
variant_list_df = []
#variant_list_df2 = []
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
variant_list_df.to_csv("AF_info.txt", index = False, header=True, sep='\t')

