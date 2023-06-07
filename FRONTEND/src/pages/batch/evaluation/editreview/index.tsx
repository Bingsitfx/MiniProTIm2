<<<<<<< HEAD
import * as React from "react";
import Box from "@mui/material/Box";
import Button from "@mui/material/Button";
import Typography from "@mui/material/Typography";
import Modal from "@mui/material/Modal";
import Content from "@/pages/shared/content";
import { useForm } from "react-hook-form";
import { Divider, TextField } from "@mui/material";
import { useEffect, useState } from "react";

const style = {
  position: "absolute" as "absolute",
  top: "50%",
  left: "50%",
  transform: "translate(-50%, -50%)",
  width: 400,
  bgcolor: "background.paper",
  boxShadow: 24,
  p: 4,
};

const ReviewModal = ({ open, handleClose, data }: any) => {
  console.log(open, handleClose, data);
  const {
    register,
    handleSubmit,
    reset,
    formState: { errors },
  } = useForm();

  useEffect(() => {
    if (open) {
      reset();
    }
  }, [open, reset]);

  const onSubmit = (formData: any) => {
    console.log(formData);
    handleClose();
  };

  return (
    <div>
      <Modal
        open={open}
        onClose={handleClose}
        aria-labelledby="modal-modal-title"
        aria-describedby="modal-modal-description"
      >
        <Box sx={style}>
          <Typography id="modal-modal-title" variant="h6" component="h2">
            Review
          </Typography>
          <Divider className="w-full border-1" />
          <Typography id="modal-modal-description" sx={{ mt: 2 }}>
            Kandidat : {data.firstname} {data.lastname}
          </Typography>
          <form onSubmit={handleSubmit(onSubmit)}>
            {/* Input hidden untuk mengirim data */}
            <input type="hidden" {...register("id")} value={data.id} />
            <input
              type="hidden"
              {...register("user_id")}
              value={data.user_id}
            />
            <TextField
              id="review"
              variant="outlined"
              label="Review"
              autoComplete="off"
              className="w-full mt-5"
              multiline
              maxRows={4}
              inputProps={{
                maxLength: 1024,
                "aria-valuemax": 1024,
              }}
              {...register("review", { required: true })}
            />
            <div className="text-sm text-red-500">{errors.review && <span>Mohon tulis reviewnya</span>}</div>
            <div className="">
              <Button
                type="submit"
                variant="contained"
                size="small"
                className="mt-4 mr-2 mb-4 bg-blue-500 hover:bg-blue-600 rounded-md"
              >
                Submit
              </Button>

              <Button
                type="button"
                onClick={handleClose}
                variant="contained"
                size="small"
                className="mt-4 ml-2 mb-4 mr-4 bg-blue-500 hover:bg-blue-600 rounded-md"
              >
                Cancel
              </Button>
            </div>
          </form>
        </Box>
      </Modal>
    </div>
  );
};

export default ReviewModal;
=======
import * as React from "react";
import Box from "@mui/material/Box";
import Button from "@mui/material/Button";
import Typography from "@mui/material/Typography";
import Modal from "@mui/material/Modal";
import Content from "@/pages/shared/content";
import { useForm } from "react-hook-form";
import { Divider, TextField } from "@mui/material";
import { useEffect, useState } from "react";

const style = {
  position: "absolute" as "absolute",
  top: "50%",
  left: "50%",
  transform: "translate(-50%, -50%)",
  width: 400,
  bgcolor: "background.paper",
  boxShadow: 24,
  p: 4,
};

const ReviewModal = ({ open, handleClose, data }: any) => {
  console.log(open, handleClose, data);
  const {
    register,
    handleSubmit,
    reset,
    formState: { errors },
  } = useForm();

  useEffect(() => {
    if (open) {
      reset();
    }
  }, [open, reset]);

  const onSubmit = (formData: any) => {
    console.log(formData);
    handleClose();
  };

  return (
    <div>
      <Modal
        open={open}
        onClose={handleClose}
        aria-labelledby="modal-modal-title"
        aria-describedby="modal-modal-description"
      >
        <Box sx={style}>
          <Typography id="modal-modal-title" variant="h6" component="h2">
            Review
          </Typography>
          <Divider className="w-full border-1" />
          <Typography id="modal-modal-description" sx={{ mt: 2 }}>
            Kandidat : {data.firstname} {data.lastname}
          </Typography>
          <form onSubmit={handleSubmit(onSubmit)}>
            {/* Input hidden untuk mengirim data */}
            <input type="hidden" {...register("id")} value={data.id} />
            <input
              type="hidden"
              {...register("user_id")}
              value={data.user_id}
            />
            <TextField
              id="review"
              variant="outlined"
              label="Review"
              autoComplete="off"
              className="w-full mt-5"
              multiline
              maxRows={4}
              inputProps={{
                maxLength: 1024,
                "aria-valuemax": 1024,
              }}
              {...register("review", { required: true })}
            />
            <div className="text-sm text-red-500">{errors.review && <span>Mohon tulis reviewnya</span>}</div>
            <div className="">
              <Button
                type="submit"
                variant="contained"
                size="small"
                className="mt-4 mr-2 mb-4 bg-blue-500 hover:bg-blue-600 rounded-md"
              >
                Submit
              </Button>

              <Button
                type="button"
                onClick={handleClose}
                variant="contained"
                size="small"
                className="mt-4 ml-2 mb-4 mr-4 bg-blue-500 hover:bg-blue-600 rounded-md"
              >
                Cancel
              </Button>
            </div>
          </form>
        </Box>
      </Modal>
    </div>
  );
};

export default ReviewModal;
>>>>>>> Ikhsan-Bootcamp
