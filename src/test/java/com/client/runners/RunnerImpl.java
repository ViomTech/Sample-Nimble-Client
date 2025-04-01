package com.client.runners;

import com.nimble.runner.ICustomRunner;

public class RunnerImpl implements ICustomRunner {

	
	@Override
	public void afterSuite() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void beforeSuite() {
//        String extentPdfReportPath = "test-output/reports/PdfReport/ExtentPdf.pdf";
//        renameFile(extentPdfReportPath);
//        log.info("PATH: "+extentPdfReportPath);
//        renameFile(extentPdfReportPath);
    }
	
//	private String renameFile(String oldPath) {
//        // Specify the old file name and path
//        File oldFile = new File(oldPath);
//        // Specify the new file name and path
//        String timestamp = new SimpleDateFormat("yyMMddHHmmss").format(new Date());
//        
//        String newPath = "test-output/reports/PdfReport/ExtentReport_" + timestamp +  ".pdf";
//        File newFile = new File(newPath);
//        try{
//            oldFile.renameTo(newFile);
//        }catch (Exception e){
//                log.info("message: " + e.getMessage());
//        }
//        return newPath;
//    }

}
