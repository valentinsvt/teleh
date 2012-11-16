package teleh

import jxl.Workbook
import jxl.WorkbookSettings
import jxl.write.*

class ExcelService {

    static transactional = true

    private File createReport(def list) {
        WorkbookSettings workbookSettings = new WorkbookSettings()
        workbookSettings.locale = Locale.default

        def file = File.createTempFile('myExcelDocument', '.xls')
//        file.deleteOnExit()

        WritableWorkbook workbook = Workbook.createWorkbook(file, workbookSettings)

        WritableFont font = new WritableFont(WritableFont.ARIAL, 12)
        WritableCellFormat format = new WritableCellFormat(font)

        def row = 0
        WritableSheet sheet = workbook.createSheet('MySheet', 0)

        sheet.setColumnView(0,20)
        sheet.setColumnView(1,20)
        sheet.setColumnView(2,25)
        sheet.setColumnView(3,40)
        sheet.setRowView(0,400, false)
        sheet.setRowView(4,400, false)

        Label label = new Label(0, 2, "A label record");
        sheet.addCell(label);

        Number number = new Number(3, 4, 3.1459);
        sheet.addCell(number);

        // Create a cell format for Arial 10 point font
        WritableFont arial10font = new WritableFont(WritableFont.ARIAL, 10);
        WritableCellFormat arial10format = new WritableCellFormat(arial10font);

        // Create the label, specifying content and format
        Label label2 = new Label(1, 0, "Arial 10 point label", arial10format);
        sheet.addCell(label2);

        Label label3 = new Label(2, 0, "Another Arial 10 point label", arial10format);
        sheet.addCell(label3);

        // Create a cell format for Times 16, bold and italic
        WritableFont times16font = new WritableFont(WritableFont.TIMES, 16, WritableFont.BOLD, true);
        WritableCellFormat times16format = new WritableCellFormat(times16font);

        // Create the label, specifying content and format
        Label label4 = new Label(3, 0, "Times 16 bold italic label", times16format);
        sheet.addCell(label4);

        WritableCellFormat integerFormat = new WritableCellFormat (NumberFormats.INTEGER);
        Number number2 = new Number(0, 4, 3.141519, integerFormat);
        sheet.addCell(number2);

        WritableCellFormat floatFormat = new WritableCellFormat (NumberFormats.FLOAT);
        Number number3 = new Number(1, 4, 3.141519, floatFormat);
        sheet.addCell(number3);

        NumberFormat fivedps = new NumberFormat("#.#####");
        WritableCellFormat fivedpsFormat = new WritableCellFormat(fivedps);
        Number number4 = new Number(2, 4, 3.141519, fivedpsFormat);
        sheet.addCell(number4);

        WritableCellFormat fivedpsFontFormat = new WritableCellFormat (times16font, fivedps);
        Number number5 = new Number(3, 4, 3.141519, fivedpsFontFormat);
        sheet.addCell(number5);

        // Get the current date and time from the Calendar object
        Date now = Calendar.getInstance().getTime();
        DateFormat customDateFormat = new DateFormat ("dd MMM yyyy hh:mm:ss");
        WritableCellFormat dateFormat = new WritableCellFormat (customDateFormat);
        DateTime dateCell = new DateTime(0, 6, now, dateFormat);
        sheet.addCell(dateCell);

//        list.each {
//            sheet.addCell(new Label(0, row, it.codigo, format))
//            sheet.addCell(new Label(1, row++, it.nombre, format))
//        }

        workbook.write();
        workbook.close();

        return file
    }

}
