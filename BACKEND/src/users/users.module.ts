import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { SequelizeModule } from '@nestjs/sequelize';
<<<<<<< HEAD
// import { users } from '../../models'; -- ini tabelnya
@Module({
  // imports:[SequelizeModule.forFeature([users])],
  controllers: [UsersController],
  providers: [UsersService],
})
export class UsersModule {}
=======
import { users, users_email } from 'models/usersSchema';

@Module({
  imports: [SequelizeModule.forFeature([users, users_email])],
  controllers: [UsersController],
  providers: [UsersService],
  exports: [UsersService]
})
export class UsersModule { }
>>>>>>> Nael-HR
