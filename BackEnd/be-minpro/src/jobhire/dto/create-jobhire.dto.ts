import { IsNotEmpty } from "class-validator";

export class CreateJobhireDto {
    @IsNotEmpty()
    joca_name : string ;

   
}
