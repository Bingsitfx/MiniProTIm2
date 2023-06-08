import { Controller, Body, Patch, Param, ParseFilePipeBuilder, HttpStatus, UseInterceptors, UploadedFile, Get, Post } from '@nestjs/common';
import { ProfileService } from './profile.service';
import { UpdateProfileDto } from './dto/update-profile.dto';
import { diskStorage } from 'multer';
import * as crypto from 'crypto'
import { FileInterceptor } from '@nestjs/platform-express';

const multerConfig = {
  storage: diskStorage({
    destination: function (req, file, cb) {
      cb(null, `${process.cwd()}/public/users`)
    },
    filename: (req, file, callback) => {
      const salt =
        Math.random().toString(36).substring(2, 15) +
        Math.random().toString(36).substring(2, 15);
      const imageNameWithSalt = file.originalname + salt;
      const md5Hash = crypto.createHmac("md5", '1234').update(imageNameWithSalt).digest('base64')
      const filename = `${md5Hash}_${file.originalname}`;
      callback(null, filename)
    }
  })
}

const validateImage = new ParseFilePipeBuilder()
  .addFileTypeValidator({
    fileType: 'webp|jpeg|jpg|png|svg',
  })
  .build({
    errorHttpStatusCode: HttpStatus.UNPROCESSABLE_ENTITY
  })

@Controller('users/profile')
export class ProfileController {
  constructor(private readonly profileService: ProfileService) { }

  @Patch('/editprofile/:id')
  @UseInterceptors(FileInterceptor('user_photo', multerConfig))
  updateProfile(@Param('id') id: string, @Body() updateProfileDto: UpdateProfileDto, @UploadedFile(validateImage) file: Express.Multer.File) {
    updateProfileDto.user_photo = file.filename
    return this.profileService.editProfile(+id, updateProfileDto);
  }

  @Patch('/changePassword/:id')
  updatePassword(@Param('id') id: string, @Body() UpdateProfileDto: UpdateProfileDto) {
    return this.profileService.changePassword(+id, UpdateProfileDto)
  }

  @Post('/addEmail/:id')
  addEmail(@Param('id') id:string,@Body() updateProfileDto:UpdateProfileDto){
    return this.profileService.addEmail(+id,updateProfileDto)
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.profileService.findOne(+id);
  }

}
