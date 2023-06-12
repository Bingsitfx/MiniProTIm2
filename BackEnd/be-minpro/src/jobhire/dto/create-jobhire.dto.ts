import { IsNotEmpty, IsNumber } from "class-validator";

export class CreateJobCategoryDto {
    @IsNotEmpty()
    joca_name : string ;

}
export class CreateEmployeeRangeDto {

    @IsNotEmpty()
    emra_range_min :number;
    emra_range_max:number;

}