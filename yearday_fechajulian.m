function [fecha_julian,year_julian]=yearday_fechajulian(year,day)
year_julian=juliandate(year,0,0);
fecha_julian=year_julian+day;
end