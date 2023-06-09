const handleMessage = (result: any, message: any, status: any) => {
    return {
      result: result,
      message: message,
      status: status,
    };
  };
  
  export default handleMessage;