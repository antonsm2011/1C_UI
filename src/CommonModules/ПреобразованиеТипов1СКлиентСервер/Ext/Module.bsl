﻿
Функция ПривестиДатуОператораК1С(Оператор, СтрокаДата) Экспорт
	
	ПараметрыПриведения = Новый Структура("Разделитель, ПорядокЧастейДаты");
	
	Если НРЕГ(Оператор) = "yahoo" Тогда
		//исходный формат "1/2/2015 M/D/YYYY"
		ПараметрыПриведения.Разделитель = "/";
		ПараметрыПриведения.ПорядокЧастейДаты = "MDY";
	ИначеЕсли НРЕГ(Оператор) = "quandl" Тогда
		//исходный формат "2015-11-01 YYYY-MM-DD"
		ПараметрыПриведения.Разделитель = "-";
		ПараметрыПриведения.ПорядокЧастейДаты = "YMD";
	Иначе
		ВызватьИсключение "ru = 'Unexpected stock operator in data formatting occured'";
	КонецЕсли;
	
	ПервыйРазделитель = СтрНайти(СтрокаДата, ПараметрыПриведения.Разделитель,,, 1);
	ВторойРазделитель = СтрНайти(СтрокаДата, ПараметрыПриведения.Разделитель,,, 2); 
	
	РазделенныеДаты = Новый Массив;
	РазделенныеДаты.Добавить(Лев(СтрокаДата, ПервыйРазделитель-1));
	РазделенныеДаты.Добавить(Сред(СтрокаДата, ПервыйРазделитель +1, ВторойРазделитель-ПервыйРазделитель-1));
	РазделенныеДаты.Добавить(Прав(СтрокаДата, СтрДлина(СтрокаДата) - ВторойРазделитель));
	
	ИндексГод = СтрНайти(ПараметрыПриведения.ПорядокЧастейДаты,"Y")-1;
	ИндексМесяц = СтрНайти(ПараметрыПриведения.ПорядокЧастейДаты,"M")-1;
	ИндексДень = СтрНайти(ПараметрыПриведения.ПорядокЧастейДаты,"D")-1;
	
	Год = РазделенныеДаты[ИндексГод];
	Месяц = РазделенныеДаты[ИндексМесяц];
	День =  РазделенныеДаты[ИндексДень];
	
	День = СтроковыеФункцииКлиентСервер.ДополнитьСтроку(День,2);
	Месяц =  СтроковыеФункцииКлиентСервер.ДополнитьСтроку(Месяц,2); 
	
	Возврат Дата(Год+Месяц+День);
	
КонецФункции

Функция ПривестиДату1СКДатеОператора(Оператор, НеформатированнаяДата) Экспорт
	
	ПараметрыПриведения = Новый Структура("Разделитель, ПорядокЧастейДаты");
	
	Если НРЕГ(Оператор) = "yahoo" Тогда
		//исходный формат "1/2/2015 M/D/YYYY"
		ФорматДаты = "ДФ=m/d/yyyy";
	ИначеЕсли НРЕГ(Оператор) = "quandl" Тогда
		//исходный формат "2015-11-01 YYYY-MM-DD"
		ФорматДаты = "ДФ=yyyy-MM-dd";
	Иначе
		ВызватьИсключение "ru = 'Unexpected stock operator in data formatting occured'";
	КонецЕсли;
	
	ОтформатированнаяДата = Формат(НеформатированнаяДата, ФорматДаты);
	
	Возврат Строка(ОтформатированнаяДата);
	
КонецФункции


